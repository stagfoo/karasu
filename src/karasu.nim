import jester
import logging
import niml
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

# AES setup
var db* = flatdb.newFlatDb("keydatabase.db", false)
discard db.load()

settings:
  port        = Port(5040)
  staticDir = "./public"

routes:
  get "/":
    resp template_encrypt(keyringKeys)
  get "/encrypt":
    resp template_encrypt(keyringKeys)
  get "/decrypt":
    resp template_decrypt(keyringKeys)    
  get "/keys":
    resp template_keys(keyringKeys, selectedKeyId)
  get "/keys/new":
    resp template_key_create()
  get "/keys/import":
    resp template_key_import()
  get "/x/key-select/details":
    resp keyInfo("selected-key")
  get "/x/key-select/@name":
    echo "key selected: " & @"name"
    resp allKeylist(@"name", keyringKeys)
  post "/x/key-created":
    db.append(%* {"name": @"name", "email": @"email", "public": generateKey(@"passp"), "private": ""})
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