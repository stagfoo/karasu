<p align="center"><img width="250px" src="/bin/icon-dark.png" />
</p>
<p align="center">a simple app to encrypt and descrypt message for transfering over unsecure messaging apps</p>
<hr>

# what would you do such a thing?
- use nim as much as possible
- make using pgp encryption easy and nice
- learn htmx
- learn nim
- test alternative to electron 


## Libraries
- sequoia-pgp key generation
- web routes routing - https://github.com/dom96/jester
- htmx for reactive programing over HTTP (https://htmx.org/)
- html DSL https://github.com/jakubDoka/niml
- webview -  New-style Zaitsev's webview wrapper (nimble seems broken so just included in `src/libs`
- database (https://github.com/ameerwasi001/TinyNimDB)

## build server
```
nim c -o:bin/app src/app.nim
```

## build webview wrapper around server
```
nim c -o:bin/viewer src/viewer.nim
```

# Design

https://www.figma.com/file/CWDTl87o4mTwwVq0ANuy0C/karasu?node-id=0%3A1

## HTMX notes

how to get data sent in the request
https://htmx.org/docs/#parameters

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





