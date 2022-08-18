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
    return actionBox("encrypt-box", "ENCRYPTING YO SECRETS FOOL ☆ ～('▽^人)", "☆ ～('▽^人)")
  of  "copy-box":
    return actionBox("copy-box", "☆ ～('▽^人)", "☆ ～('▽^人)")
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