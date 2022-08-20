import niml
import components
import ../types

func template_keys*(keylist: array[0..8, KeyringKey], selectedKeyId: string): string = 
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
                @allKeylist selectedKeyId, keylist
                @keyInfo "Key Info:"
                divider class & "box ghost":
                  divider class & "grid-container grid-1-1-h":
                    button class & "button secondary":
                      "Delete x"
                    button class & "button primary":
                      "Copy []"
                divider class & "key-list-actions grid-container grid-1-1-v":
                  p "Add/Create keys:"
                  a class & "button", href & "/keys/new":
                    "create key pair **"
                  a class & "button", href & "/keys/import":
                    "import key/s <<"


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
                @createKeyInfo "Create key pair ☆ ～('▽^人)"

func template_key_import*(): string = 
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
                @importKeyInfo "Import keys:"