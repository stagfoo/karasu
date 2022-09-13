import niml
import components
import jsony
import std/json
# What does the * do in nim?
# Answer: its means export
func template_decrypt*(keylist: seq[JsonNode]): string = 
  return niml:
    doctype_html
    html:
      head lang & "en":
        head:
          @metadata "Karasu#"
        body:
          divider id & "app":
            #TODO pass active route
            @navbar "navbar", "decrypt"
            divider class & "page":
              # REMOVE FORM
              form `hx-post` & "decrypt", `hx-target` & "#copy-box", `hx-swap` & "outerHTML":
                divider class & "grid-container grid-1-2-2-v":
                  @keySelector "Decrypt for key:", keylist
                  @actionBox "decrypt-box", "decrypt //", "copy-box", "decrypt", ""
                  @actionBox "copy-box", "Copy []", "copy-box", "your encrypted string will appear here", ""
                  @model "enter your passcode"
              script:
                """
                let passphrase = ""
                document.querySelector('#model input').addEventListener('keydown', async (e) => {
                  if(e.keyCode == 13){
                    passphrase = e.target.value
                    const data = await handleDecryptMessage(state.selectedKey.private, passphrase, document.querySelector('#decrypt-box textarea').value)
                    document.querySelector('#copy-box textarea').value = data
                    toggleModel()
                  }
                })
                document.querySelector('#decrypt-box button').addEventListener('click', async (e) => {
                  toggleModel()
                })
                document.querySelector('#copy-box button').addEventListener('click', async (e) => {
                  copyToClipboard(document.querySelector('#copy-box textarea'))
                })
                """