import niml
import components

# What does the * do?
func template_decrypt*(): string = 
  return niml:
    doctype_html
    html:
      head lang & "en":
        head:
          @metadata "Karasu#"
        body:
          divider id & "app":
            #TODO pass active route
            @navbar "navbar"
            divider class & "page":
              divider class & "grid-container grid-1-2-2-v":
                @keySelector "for key:"
                @actionBox "decrypt-box", "Decrypt ??", "paste the encrypted string here"
                @actionBox "copy-box", "Copy []", "your decrypted string will appear here"