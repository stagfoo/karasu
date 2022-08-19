# nim-playing

create an app using nim
- use nim as much as possible 
- sequoia-pgp key generation
- html routing - https://github.com/dom96/jester
- htmx for reactive programing (https://htmx.org/)
- html DSL https://github.com/jakubDoka/niml
- webview -  New-style Zaitsev's webview wrapper
- database ? https://github.com/ameerwasi001/TinyNimDB

build webapp
```
nim c -o:bin/app src/app.nim
```

build webview wrapper
```
nim c -o:bin/viewer src/viewer.nim
```

# Design 

https://www.figma.com/file/CWDTl87o4mTwwVq0ANuy0C/karasu?node-id=0%3A1

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




