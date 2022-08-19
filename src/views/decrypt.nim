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
            @navbar "navbar", "decrypt"
            divider class & "page":
              divider class & "grid-container grid-1-2-2-v":
                @keySelector "for key:"
                @actionBox "encrypt-box", "Encrypt //", "copy-box", "paste or type the text you want to encrypt here"
                @actionBox "copy-box", "Copy []", "copy-box", "your encrypted string will appear here"