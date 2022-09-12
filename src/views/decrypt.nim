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
              form `hx-post` & "decrypt", `hx-target` & "#copy-box", `hx-swap` & "outerHTML":
                divider class & "grid-container grid-1-2-2-v":
                  @keySelector "Decrypt for key:", keylist
                  @actionBox "decrypt-box", "decrypt //", "copy-box", "decrypt", ""
                  @actionBox "copy-box", "Copy []", "copy-box", "your encrypted string will appear here", ""
              script:
                """
                document.querySelector('#decrypt-box button').addEventListener('click', async (e) => {
                  const passphrase = prompt("enter your passphase")
                  const data = await handleDecryptMessage(state.selectedKey.private, passphrase, document.querySelector('#decrypt-box textarea').value)
                  console.log('data', data)
                  document.querySelector('#copy-box textarea').value = data
                })
                """