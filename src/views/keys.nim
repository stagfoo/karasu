import niml
import components

func template_keys*(): string = 
  return niml:
    doctype_html
    html:
      head lang & "en":
        head:
          @metadata "Karasu#"
        body:
          divider id & "app":
            @navbar "navbar", "keys"
            divider class & "page":
              divider class & "grid-container":
                @keylist "add new key +"
                @keyInfo "key info:"
                divider class & "box ghost":
                  divider class & "grid-1-1-h":
                    button class & "secondary":
                      "Delete x"
                    button class & "primary":
                      "Copy []"



      
func template_key_create*(): string = 
  return niml:
    doctype_html
    html:
      head lang & "en":
        head:
          @metadata "Karasu#"
        body:
          divider id & "app":
            @navbar "navbar", "keys"
            divider class & "page":
              divider class & "grid-container":
                @keyInfo "key info:"
                divider class & "box ghost":
                  divider class & "grid-1-1-h":
                    button class & "secondary":
                      "Save x"