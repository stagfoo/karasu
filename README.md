<p align="center"><img width="250px" src="/bin/icon-dark.png" />
</p>
<p align="center">a simple app to encrypt and descrypt message for transfering over unsecure messaging apps</p>
<hr>

# why would you do such a thing?
- use nim as much as possible
- make using pgp encryption easy and nice
- learn htmx or "go back to monke"
- learn nim
- test alternative to electron 


## Libraries
- ~~sequoia-pgp key generation (https://github.com/ba0f3/sequoia.nim)~~
- some PGP library? currently the endpoints return dumby stuff
- server - https://github.com/dom96/jester
- HTMX for reactive programing over HTTP (https://htmx.org/)
- HTML DSL https://github.com/jakubDoka/niml
- webview -  New-style Zaitsev's webview wrapper (nimble seems broken so just included in `src/libs`
- database (https://github.com/ameerwasi001/TinyNimDB)

## build app
```
nimble install;
./build;
./run;
```

# Design

https://www.figma.com/file/CWDTl87o4mTwwVq0ANuy0C/karasu?node-id=0%3A1

- some screen may differ after creation

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
### HTMX problem
selecting a key in a list worked but the scroll position of the list would be reset, if you reloaded the full list but if you didn't reload the full list other key items would not be unselected


### Crypto Libraries
- nim is newer, PGP is older not much support
- [PGP seems disliked in forums](https://www.engadget.com/2013-08-12-pgp-inventor-doesnt-use-pgp-because-it-doesnt-run-well-on-a-m.html?guccounter=1&guce_referrer=aHR0cHM6Ly9kdWNrZHVja2dvLmNvbS8&guce_referrer_sig=AQAAABNaq2vaDQnfHqhzVYdMHrEP3jBz22QUFxIPKZxxRae6SQbjg4yUxLMV71aGyZyfbi9-fP40K5l1eH_WHXE3Ug5IDG-rolAsjHlFT5YQr_M-cU9oKvxUteJJNr10SjWzGDEie0sweylJ822CVyBKWAuswTJjz6kSQZeJhbrcNFyT)
- AES is widely recommend
- XXTEA has also been mentioned in forums as an alternative (if you have more the 5kb of ram)
- AES and XXTEA both have nim packages https://github.com/jangko/nimAES https://github.com/xxtea/xxtea-nim#xxtea-for-nim
- https://github.com/OHermesJunior/nimRC4
- AES has been approved by the NSA(us) for top secret docs and is used by keypass
- AES doesnt support keypairs :(
