import niml


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

func navbar*(id:string, active:string): string =
  # wtf is this shit lol
  case active
  of "keys":
    return niml:
            divider id & @id, class & "nav grid-container":
              a href & "/", class & "":
                "encrypt"
              a href & "/decrypt", class & "":
                "decrypt"
              a href & "/keys", class & "active":
                "keys"
  of "decrypt":
    return niml:
            divider id & @id, class & "nav grid-container":
              a href & "/", class & "":
                "encrypt"
              a href & "/decrypt", class & "active":
                "decrypt"
              a href & "/keys", class & "":
                "keys"
  else:
    return niml:
            divider id & @id, class & "nav grid-container":
              a href & "/", class & "active":
                "encrypt"
              a href & "/decrypt", class & "":
                "decrypt"
              a href & "/keys", class & "":
                "keys"


func keySelector*(title:string): string =
  return niml:
        divider class & "recipients-selector box thin filled grid-container grid-1-2-h":
          span class & "title":
            @title
          select:
            option:
                "alex"
            option:
                "alex"
            option:
                "alex"
            option:
                "alex"
func actionBox*(id: string, text: string, target: string , placeholder: string): string =
  return niml:
    divider id & @id, class & "action box" :
        textarea class & "borderless htmx-include", placeholder & @placeholder
        button class & "primary", `hx-swap` & "outerHTML", `hx-target` & @("#" & target), `hx-post` & @("/ux/encrypt/" & id), `hx-trigger` & "click":
         @text

func keyItem*(name: string, selected:string): string =
  return niml:
      button class & @("box item key " & selected):
        span:
          @name
        i class & "pair":
          "PP"

func keylist*(buttonText: string): string =
  return niml:
        divider class & "box recipients-list":
          button class & "":
            @buttonText
          @keyItem "alex", "selected"
          @keyItem "maki", ""
          @keyItem "lia", ""
          @keyItem "adam", ""
          @keyItem "luke", ""
          @keyItem "marty", ""

func keyInfoInput*(label: string, value: string): string =
  return niml:
          divider class & "input grid-container grid-1-3-h":
            label:
              @label
            input class & @("input-" & label), type & "text", value & @value

func keyInfo*(title: string): string =
  return niml:
    divider class & "box borderless padding-0":
      p:
        @title
      @keyInfoInput "name", "alex"
      @keyInfoInput "email", "alex@email.com"
      @keyInfoInput "crypto", "SHA265"
      @keyInfoInput "added", "alex"
      @keyInfoInput "type", "alex"
