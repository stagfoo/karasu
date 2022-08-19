# nim-playing

create an app using nim
- use nim as much as possible 
- sequoia-pgp key generation
- html templates - https://github.com/onionhammer/nim-templates
- htmx for reactive programing (https://htmx.org/)
- webview


build webapp
```
nim c -o:bin/app src/app.nim
```

build webview wrapper
```
nim c -o:bin/viewer src/viewer.nim
```

# Design 

<iframe style="border: 1px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FCWDTl87o4mTwwVq0ANuy0C%2Fkarasu%3Fnode-id%3D0%253A1" allowfullscreen></iframe>


## htmx example

```
<div id="parent-div">
          <p>Foo</p>
        </div>
        <button 
            hx-post="/clicked"
            hx-trigger="click"
            hx-target="#parent-div"
            hx-swap="innerHTML"
        >
            Click Me!
        </button>
```        

## HTMX

how to get data sent in the request
https://htmx.org/docs/#parameters