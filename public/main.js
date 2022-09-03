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

(async () => {
  const passphrase = "king"
  // const { 
  //   armoredKeyPrivateKey,
  //   armoredKeyPublicKey
  // } = await createNewKey('Alex', 'yo@stagfoo.com', passphrase);
  // localStorage.setItem('armoredKeyPrivateKey', armoredKeyPrivateKey)
  // localStorage.setItem('armoredKeyPublicKey', armoredKeyPublicKey)
  const armoredKeyPrivateKey = localStorage.getItem('armoredKeyPrivateKey')
  const armoredKeyPublicKey = localStorage.getItem('armoredKeyPublicKey')

  const armoredMessage = await encryptMessage(armoredKeyPublicKey, "Hello World");
  
  console.log(armoredMessage);
  const { data: decrypted } = await decryptMessage(armoredKeyPrivateKey, passphrase, armoredMessage)

  console.log(decrypted); // 'Hello, World!'
})();
// const { data: decrypted } = await openpgp.decrypt({
//   message: encryptedMessage,
//   passwords: ['secret stuff'], // decrypt with password
//   format: 'binary' // output as Uint8Array
// });
// console.log('decrypted', decrypted); // Uint8Array([0x01, 0x01, 0x01])
