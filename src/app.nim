import jester

import views/encrypt
import views/decrypt
import views/keys
import views/components

# Learn show to set ENV

type
  NewKeyringKey = object
    id: string
    name: string
    shortname: string
    email: string
    passphrase: string
    private: string
    public: string

type
  KeyringKey = object
    id: string
    name: string
    shortname: string
    email: string
    private: string
    public: string

let keyringKeys = [
  KeyringKey(name: "alex", id: "x1", shortname: "alex", email: "yo@stagfoo.com"),
  KeyringKey(name: "maki", id: "x2", shortname: "maki", email: "maki@stagfoo.com"),
]

settings:
  port        = Port(5040)
  staticDir = "./public"

func template_encrypt_components(component: string): string = 
  case component
  of  "encrypt-box":
    return actionBox("encrypt-box", "Copy []", "copy-box", """
  -----BEGIN PGP MESSAGE-----
Version: BCPG v1.63

hQEOA7AXaMxqYSTbEAQAxn2YTISyg7JlP5OYLEAACLd8YWSYyoZNX1z86nzRG5Fu
pEXu2gpq7Y+gsjuh/SfYMNgQ+uHJWanwa/ILnEN5pL4kmTGLBxr5PtTh7FgJHlsq
ITs+g6j7fdF5AOTF7MY1GWjrf4UKWFZoNpYk2y4j7HrpQ7G6BgBhrQwnMhCnr7QE
AM+KHsTd1YBS8oAPggxR3ngG9elQ122iexh3b2dog819im3tjsBw3CDdl/WFiZCx
E4Hd/h94e/wYdE72bhIT4NqiMTieoFNu/WbzfIXGn1hW9aWX3jHbxVDKzBnb/4T8
HwDIr+cS/1eXLymDHcB078NtcWRc0d3XQ6idxlWUqnaL0kABxSpETvZTrJrZCLlC
q+iSYLSsX+9+pfZlxLWG+ejeeEg7ld03xdlBBALWQnCKF6XbAgs0zhzbpBO71/zZ
wzVb
=Uipu
-----END PGP MESSAGE-----
  
  """,)
  of  "copy-box":
    return actionBox("copy-box", "☆ ～('▽^人)",  "copy-box", """
  -----BEGIN PGP MESSAGE-----
Version: BCPG v1.63

hQEOA7AXaMxqYSTbEAQAxn2YTISyg7JlP5OYLEAACLd8YWSYyoZNX1z86nzRG5Fu
pEXu2gpq7Y+gsjuh/SfYMNgQ+uHJWanwa/ILnEN5pL4kmTGLBxr5PtTh7FgJHlsq
ITs+g6j7fdF5AOTF7MY1GWjrf4UKWFZoNpYk2y4j7HrpQ7G6BgBhrQwnMhCnr7QE
AM+KHsTd1YBS8oAPggxR3ngG9elQ122iexh3b2dog819im3tjsBw3CDdl/WFiZCx
E4Hd/h94e/wYdE72bhIT4NqiMTieoFNu/WbzfIXGn1hW9aWX3jHbxVDKzBnb/4T8
HwDIr+cS/1eXLymDHcB078NtcWRc0d3XQ6idxlWUqnaL0kABxSpETvZTrJrZCLlC
q+iSYLSsX+9+pfZlxLWG+ejeeEg7ld03xdlBBALWQnCKF6XbAgs0zhzbpBO71/zZ
wzVb
=Uipu
-----END PGP MESSAGE-----
  
  """,)
  else:
    return "( ´ ∀ `)ノ～ ♡ Failed ♡ "
  # check key for correct return interactions


routes:
  get "/":
    resp template_encrypt()
  get "/encrypt":
    resp template_encrypt()
  post "/encrypt":
    resp template_encrypt()
  # possible scoping style of htmx interaction
  post "/ux/encrypt/@component":
    resp template_encrypt_components(@"component")
  get "/decrypt":
    resp template_decrypt()
  post "/decrypt/@id":
    resp template_decrypt()
  get "/keys":
    resp template_keys()
  get "/keys/@id":
    resp template_keys()
  delete "/keys/@id":
    resp template_keys()
  get "/keys/create":
    resp template_key_create()
  get "/keys/import":
    resp template_key_create()