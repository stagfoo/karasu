import jester
import logging
import niml
import jsony
# Crypto imports
import murmurhash
import flatdb
import std/json
import std/os
import std/base64

# My imports (´▽`)
import views/encrypt
import views/decrypt
import views/keys
import views/components
import types
import data/database
import domain

type
  KeyringKey = object
    name: string 
    id: string
    email: string
    public: string
    private: string


# AES setup
var db* = flatdb.newFlatDb("keydatabase.db", false)
discard db.load()

settings:
  port        = Port(5040)
  staticDir = "./public"

routes:
  get "/":
    var keys = db.query(has("name"))
    resp template_encrypt(keys)
  get "/encrypt":
    var keys = db.query(has("name"))
    resp template_encrypt(keys)
  get "/decrypt":
    var keys = db.query(has("name"))
    resp template_decrypt(keys)
  get "/x/keys/@keyid":
    resp db[@"keyid"]
  get "/keys":
    # I cant find docs on how to return all options?
    # get all ids that have a name
    var keys = db.query(has("name"))
    resp template_keys(keys, selectedKeyId)
  get "/keys/new":
    resp template_key_create()
  get "/keys/import":
    resp template_key_import()
  get "/x/key-select/details":
    resp keyInfo("selected-key")
  get "/x/key-select/@name":
    echo "key selected: " & @"name"
    var keys = db.query(has("name"))
    resp allKeylist(@"name", keys)
  post "/json/key-created":
    var newKey = parseJson(request.body)
    db.append(%* {"name": newKey["name"].getStr(), "email": newKey["email"].getStr(), "public": newKey["public"].getStr() , "private": newKey["private"].getStr()})
    resp """
      {"done": "true"}
    """
  post "/x/key-created":
    var body = niml:
      divider id & "actions":
        a class & "button primary expand-w", href & "/keys":
          "<< Your key pair was created ヾ(・3・*)"
    resp body
  post "/x/key-imported":
    # check grid-container - doesnt animate well
    var body = niml:
      divider id & "actions":
        a class & "button primary expand-w", href & "/keys":
          "<< Your key pair was imported (ﾉ^^)乂(^^ )ﾉ"
    resp body
  post "/keys/new-key":
    echo "key pair created: " & @"name"
    resp "key pair created"
  post "/encrypt":
    # database save
    echo @"selectkey"
    echo @"encrypt-box"
    echo @"copy-box"
    resp copyBox("copy-box", "Copy []", "copy-box", "", fakeTextMessage)
  post "/decrypt":
    echo @"selectkey"
    echo @"decrypt-box"
    echo @"copy-box"
    resp copyBox("copy-box", "Copy []", "copy-box", "", "Hello world")