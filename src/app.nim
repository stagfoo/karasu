import htmlgen
import jester

import views/encrypt
import views/decrypt
import views/keys
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

const AFTER_CLICK = """
  <p>Foobar</p>
"""

const KEY_OPTIONS = """
 <option>alex</option>
  <option>alex</option>
  <option>alex</option>
  <option>alex</option>
  <option>alex</option>
  <option>alex</option>
  <option>alex</option>
"""

func interactBus(name: string): string = 
  case name
  of  "key-select":
    return KEY_OPTIONS
  else:
    return ""
  # check key for correct return interactions


routes:
  get "/":
    resp template_encrypt()
  get "/encrypt":
    resp template_encrypt()
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
  post "/x/@name":
    resp interactBus(@"name")