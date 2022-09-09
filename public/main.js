var state = {
  selectedKey: {}
}

async function createNewKey(name, email, passphrase) {
  const { privateKey, publicKey } = await openpgp.generateKey({
    type: 'rsa', 
    rsaBits: 4096, 
    userIDs: [{ name, email }],
    passphrase
  });
  return { 
    armoredKeyPrivateKey: privateKey,
    armoredKeyPublicKey: publicKey,
  }
}

async function createDecryptionKey(armoredKeyPrivateKey, passphrase) {
  const privateKey =  await openpgp.decryptKey({
    privateKey: await openpgp.readPrivateKey({ armoredKey: armoredKeyPrivateKey }),
    passphrase: passphrase
  });
  return privateKey
}
async function createEncryptionKey(armoredKeyPublicKey) {
  return await openpgp.readKey({ armoredKey: armoredKeyPublicKey });
}

async function encryptMessage(armoredKeyPublicKey, text) {
  return await openpgp.encrypt({
    message: await openpgp.createMessage({ text }),
    encryptionKeys: await createEncryptionKey(armoredKeyPublicKey)
});
}

async function decryptMessage(armoredKeyPrivateKey, passphrase, armoredMessage) {
  return await openpgp.decrypt({
    message: await openpgp.readMessage({ armoredMessage }),
    expectSigned: false,
    decryptionKeys: await createDecryptionKey(armoredKeyPrivateKey, passphrase)
  });
}

async function saveKeys(key) {
  const response = await fetch('/json/key-created', {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    mode: 'cors', 
    cache: 'no-cache', 
    credentials: 'same-origin', 
    headers: {
      'Content-Type': 'application/json'
    },
    referrerPolicy: 'no-referrer', 
    body: JSON.stringify(key)
  });
  return response.json();
}

async function getKeys(keyId) {
  const response = await fetch(`/x/keys/${keyId}`, {
    method: 'GET',
    mode: 'cors', 
    cache: 'no-cache', 
    credentials: 'same-origin', 
    headers: {
      'Content-Type': 'application/json'
    },
    referrerPolicy: 'no-referrer', 
  });
  return response.json();
}


async function handleCreateNewKey(passphrase, name, email){
  const { 
    armoredKeyPrivateKey,
    armoredKeyPublicKey
  } = await createNewKey(name, email, passphrase);

  return await saveKeys({
    name,
    email,
    private:armoredKeyPrivateKey,
    public: armoredKeyPublicKey
  })
}

async function handleEncryptMessage(armoredKeyPublicKey, message){
  return await encryptMessage(armoredKeyPublicKey, message);
}

async function handleDecryptMessage(armoredKeyPrivateKey, passphrase, armoredMessage) {
  const { data: decrypted } = await decryptMessage(armoredKeyPrivateKey, passphrase, armoredMessage)
  return decrypted;
}
