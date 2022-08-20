import niml
import components
import ../types
# What does the * do in nim?
# Answer: its means export
func template_encrypt*(keylist: array[0..8, KeyringKey]): string = 
  return niml:
    doctype_html
    html:
      head lang & "en":
        head:
          @metadata "Karasu#"
        body:
          divider id & "app":
            @navbar "navbar", "encrypt"
            divider class & "page":
              form `hx-post` & "encrypt", `hx-target` & "#copy-box", `hx-swap` & "outerHTML":
                divider class & "grid-container grid-1-2-2-v":
                  @keySelector "Encrpyt for key:", keylist
                  @actionBox "encrypt-box", "Encrypt //", "copy-box", "paste or type the text you want to encrypt here", ""
                  @actionBox "copy-box", "Copy []", "copy-box", "your encrypted string will appear here", ""