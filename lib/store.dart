import 'package:dart_pg/dart_pg.dart';
import 'package:flutter/material.dart';
import 'package:slugid/slugid.dart';

var localDBFile = 'database.toml';

//TODO how can i set this like a function?
class PGPKey {
  String name = '';
  String email = '';
  late PublicKey publicKey;
  late PrivateKey privateKey;
  Slugid id = Slugid.nice();
  String createdAt = '';
  String updatedAt = '';
  String deletedAt = '';
}

PGPKey createFakeKey(String name, PublicKey pub, PrivateKey priv) {
  var newKey = PGPKey();
  newKey.name = name;
  newKey.publicKey = pub;
  newKey.privateKey = priv;
  return newKey;
}

class PGPKeyPair {
  String publicKey = '';
  String privateKey = '';
}

class GlobalState extends ChangeNotifier {
  int currentNavbarIndex = 0;
  List<String> bucket = [];
  List<PGPKey> keyring = [];
  String textToEncrypt = '';
  String encryptedText = '';
  String textToDecrypt = '';
  String decryptedText = '';
  String selectedPublicKey = '';
  String selectedPrivateKey = '';
  PGPKey selectedPGPKey = PGPKey();
  String selectedKeyPassword = '';

  String newKeyName = '';
  String newKeyEmail = '';
  String newKeyPassword = '';
  String newKeyPublicKey = '';
  String newKeyPrivateKey = '';
  Slugid newKeyId = Slugid.nice();

 void updateNewKeyDetails(String name, String value) {
    switch (name) {
      case 'name':
        newKeyName = value;
        break;
      case 'email':
        newKeyEmail = value;
        break;
      case 'password':
        newKeyPassword = value;
        break;
      default:
        print('no match');
    }
  }  

  void addNewKey(String name, PublicKey pub, PrivateKey priv, String email) {
    var newKey = PGPKey();
    newKey.name = name;
    newKey.publicKey = pub;
    newKey.privateKey = priv;
    newKey.privateKey = priv;
    newKey.email = email;
    newKey.createdAt = DateTime.now().toString();
    newKey.updatedAt = DateTime.now().toString();
    newKey.deletedAt = '';
    keyring.add(newKey);
    notifyListeners();
  }

  
  void setSelectedKeyPassword(String value) {
    selectedKeyPassword = value;
  }

  void saveNavbarIndex(int value) {
    currentNavbarIndex = value;
    notifyListeners();
  }
  void selectPublicKey(String key) {
    selectedPublicKey = key;
    notifyListeners();
  }
  void selectPrivateKey(String key) {
    selectedPrivateKey = key;
    notifyListeners();
  }
  void setTextToEncrypt(String text) {
    print(text);
    textToEncrypt = text;
  }
  void setTextToDecrypt(String text) {
    textToDecrypt = text;
    notifyListeners();
  }
  void setDecryptedText(String text) {
    decryptedText = text;
    notifyListeners();
  }
  void setEncryptedText(String text) {
    encryptedText = text;
    notifyListeners();
  }
}
