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

func navbar*(id:string, active: string): string =
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
func actionBox*(id: string, text: string, placeholder: string): string =
  return niml:
    divider id & @id, class & "action box" :
        textarea class & "borderless htmx-include", placeholder & @placeholder
        button class & "primary", `hx-swap` & "outerHTML", `hx-target` & @("#" & id), `hx-post` & @("/ux/encrypt/" & id), `hx-trigger` & "click":
         @text