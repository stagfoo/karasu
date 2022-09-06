import niml
import jsony
import std/json

type
  KeyringKey* = object
    name: string
    id: string
    email: string
    public: string
    private: string


func metadata*(title: string): string =
  return niml:
        meta charset & "UTF-8"
        meta `http-equiv` & "X-UA-Compatible", content & "IE=edge"
        meta name & "viewport", content & "width=device-width, initial-scale=1.0"
        script src & "/htmx.js"

        link rel & "stylesheet", href & "/reasonable-colors.css"
        link rel & "stylesheet", href & "/main.css"
        link rel & "stylesheet", href & "https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@100;200;500&amp;display=swap"
        title @title
        script:
          """
            function copyToClipBoard() {
            var content = document.getElementById('copy-box');
            content.select();
            document.execCommand('copy');
            alert("Successfully Copied!");
            }
          """
        script src & "https://unpkg.com/openpgp@5.4.0/dist/openpgp.js"
        script src & "/main.js"

func navbar*(id:string, active:string): string =
  return niml:
          divider id & @id, class & "nav grid-container":
            a href & "/", class & @(if active == "encrypt": "active" else: ""):
              "encrypt"
            a href & "/decrypt", class & @(if active == "decrypt": "active" else: ""):
              "decrypt"
            a href & "/keys", class & @(if active == "keys": "active" else: ""):
              "keys"     
        
func actionBox*(id: string, text: string, target: string , placeholder: string, value: string): string =
  return niml:
      divider id & @id, class & "action box" :
            textarea name & @id, class & "borderless htmx-include", placeholder & @placeholder:
              @value
            button class & "primary", type & "submit":
              @text

func copyBox*(id: string, text: string, target: string , placeholder: string, value: string): string =
  return niml:
      divider id & @id, class & "action box" :
          form `hx-post` & "encrypt", `hx-target` & @("#" & target), `hx-swap` & "outerHTML":
            textarea name & @id, class & "borderless htmx-include", placeholder & @placeholder:
              @value
            button class & "primary", onclick & "":
              @text

func keyItem*(name: string, selectedKeyId:string): string =
  var selectedClass = (if selectedKeyId == name: "selected" else: "")
  return niml:
      button class & @("box item key " & selectedClass), `hx-trigger` & "click", `hx-target` & "#key-list", `hx-get` & @("/x/key-select/" & name),  `hx-swap` & "outerHTML":
        span:
          @name
        i class & "pair":
          "PP"

func keyInfoInput*(label: string, value: string, disabled:bool): string =
  if disabled:
    return niml:
        divider class & "input grid-container grid-1-3-h":
          label:
            @label
          input name & @label, class & @("htmx-include input-" & label), type & "text", value & @value, disabled & "true"
  else:
    return niml:
          divider class & "input grid-container grid-1-3-h":
            label:
              @label
            input name & @label, class & @("htmx-include input-" & label), type & "text", value & @value

func keyInfo*(title: string): string =
  return niml:
      divider class & "box borderless padding-0":
        p:
          @title
        @keyInfoInput "name", "alex", true
        @keyInfoInput "email", "alex@email.com", true
        @keyInfoInput "crypto", "SHA265", true
        @keyInfoInput "passphrase", "alex", true
        @keyInfoInput "type", "Single Key", true

func createKeyInfo*(title: string): string =
  return niml:
    form id & "key-created", `hx-post` & "/x/key-created", `hx-target` & "#actions":
      divider class & "box borderless padding-0":
        p:
          @title
        @keyInfoInput "name", "alex", false
        @keyInfoInput "email", "alex@email.com", false
        @keyInfoInput "encrypt", "AES", true
        @keyInfoInput "passp", "example-password", false
        @keyInfoInput "type", "Pair Key", false

      divider id & "actions":
          a class & "button secondary", href & "/keys":
            "Cancel"
          button id & "key-created-button", class & "button primary", type & "click":
            "Create key pair **"
    script:
      """
        document.getElementById('key-created-button').addEventListener("click", () => {
          const form = document.querySelector('#key-created');
          const data = Object.fromEntries(new FormData(form).entries());
          handleCreateNewKey(data.passp, data.name, data.email)
        })
      """ 

func importKeyInfo*(title: string): string =
  return niml:
    form `hx-post` & "/x/key-imported", `hx-target` & "#actions":
      #copy this for create as well
      divider class & "grid-container grid-1-2-2-v":
        p:
          @title
        divider id & "public-key", class & "action box" :
              textarea name & "public-key", class & "borderless htmx-include", placeholder & "paste your public key"
        divider id & "private-key", class & "action box" :
              textarea name & "private-key", class & "borderless htmx-include", placeholder & "paste your private key"
        divider id & "actions":
          a class & "button secondary", href & "/keys":
            "Cancel X"
          button class & "button primary", type & "submit" :
            "Import Key/s <<"


func optionList(keylist: seq[JsonNode]): string =
  # I would like to do this as a niml but niml are string so this works ┐( ´3` )┌
  var options = ""
  for i, item in keylist:
    var name = item["name"].getStr()
    var email = item["email"].getStr()
    var id = item["_id"].getStr()
    options = options & "<option value='" & id  & "' >" & name & "(" & email &  ")" & "    [P]</option>"
  return options

func keyItemList(keylist: seq[JsonNode], selectedKeyId: string): string =
  # I would like to do this as a niml but niml are string so this works ┐( ´3` )┌
  var list = ""
  for i, item in keylist:
    var name = item["name"].getStr()
    list = list & keyItem(name, selectedKeyId)
  return list

func keySelector*(title:string, keylist: seq[JsonNode]): string =
  return niml:
    divider class & "recipients-selector box thin filled grid-container grid-1-2-h hx-include":
      span class & "title":
        @title
      select name & "selectkey", onchange & "onchangeKeySelector(event)":
        @optionList keylist

# possible remove this element?
func allKeylist*(selectedKey: string, keylist: seq[JsonNode]): string =
  return niml:
        divider id & "key-list", class & "box ghost":
          @keySelector "Info for key:", keylist
          # rethink how to do this selec logic 