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

async function testingFunction() {
  const passphrase = "king"
  const { 
    armoredKeyPrivateKey,
    armoredKeyPublicKey
  } = await createNewKey('Alex', 'example@stagfoo.com', passphrase);

  localStorage.setItem('armoredKeyPrivateKey', armoredKeyPrivateKey)
  localStorage.setItem('armoredKeyPublicKey', armoredKeyPublicKey)

  await saveKeys({
    name: "Alex",
    email: "example@stagfoo.com",
    private:armoredKeyPrivateKey,
    public: armoredKeyPublicKey
  })

  // const armoredKeyPrivateKey = localStorage.getItem('armoredKeyPrivateKey')
  // const armoredKeyPublicKey = localStorage.getItem('armoredKeyPublicKey')

  const armoredMessage = await encryptMessage(armoredKeyPublicKey, "Hello World");
  
  console.log(armoredMessage);
  const { data: decrypted } = await decryptMessage(armoredKeyPrivateKey, passphrase, armoredMessage)

  console.log(decrypted); // 'Hello, World!'
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