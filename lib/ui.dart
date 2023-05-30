//Libs
import 'package:dart_pg/dart_pg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

//Local
import 'actions.dart';
import 'store.dart';
import 'const.dart';

//------------------------PAGE----------------------------

class HomePage extends StatelessWidget {
  final GlobalState state;
  const HomePage({Key? key, required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<GlobalState>(builder: (context, state, widget) {
        return BottomBar(state: state);
      }),
      body: Consumer<GlobalState>(builder: (context, state, widget) {
        return Column(
          children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(FOR_KEYS)),
                Expanded(
                  flex: 2,
                  child: Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                        state.keyring.isNotEmpty,
                    widgetBuilder: (BuildContext context) =>
                        DropdownButton<String>(
                      value: state.selectedPublicKey,
                      items: state.keyring.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.id.toString(),
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        handleSelectKey(state, value!);
                      },
                    ),
                    fallbackBuilder: (BuildContext context) => OutlinedButton(
                        onPressed: () {
                          navigateToPage(state, 'new-key', 2);
                        },
                        child: Text(CREATE)),
                  ),
                ),
              ],
            ),
            Padding(
              child: BorderedItem(
                  title: "password",
                  onChanged: (text) {
                    setSelectedKeyPassword(state, text);
                  },
                  state: state),
              padding: EdgeInsets.all(16),
            ),
            Column(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (text) {
                      handleAddTextToEncrypt(state, text);
                    },
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      handleEncryptMessage(state);
                    },
                    child: Text(ENCRYPT)),
                Container(
                  child: Text(state.encryptedText,
                      style: const TextStyle(fontSize: 7)),
                  height: 200,
                  padding: const EdgeInsets.all(10),
                ),
                OutlinedButton(
                    onPressed: () {
                      copyToClipboard(state, state.encryptedText);
                    },
                    child: Text(COPY))
              ],
            ),
          ],
        );
      }),
    );
  }
}

class DecryptPage extends StatelessWidget {
  final GlobalState state;
  const DecryptPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<GlobalState>(builder: (context, state, widget) {
        return BottomBar(state: state);
      }),
      body: Consumer<GlobalState>(builder: (context, state, widget) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(FOR_KEYS)),
                Expanded(
                    flex: 2,
                    child: Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state.keyring.isNotEmpty,
                      widgetBuilder: (BuildContext context) =>
                          DropdownButton<String>(
                        value: state.selectedPublicKey,
                        items: state.keyring.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.id.toString(),
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          handleSelectKey(state, value!);
                        },
                      ),
                      fallbackBuilder: (BuildContext context) => OutlinedButton(
                          onPressed: () {
                            navigateToPage(state, 'new-key', 2);
                          },
                          child: Text(CREATE)),
                    )),
              ],
            ),
            Padding(
              child: BorderedItem(
                  title: "password",
                  onChanged: (text) {
                    setSelectedKeyPassword(state, text);
                  },
                  state: state),
              padding: EdgeInsets.all(16),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO move to component
                TextFormField(
                  onChanged: (value) => handleAddTextToDecrypt(state, value),
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 200,
                    ),
                  ),
                  scrollController: ScrollController(),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                OutlinedButton(
                    onPressed: () {
                      handleDecryptMessage(state);
                    },
                    child: Text(DECRYPT)),
                Container(
                  child: Text(state.decryptedText,
                      style: const TextStyle(fontSize: 7)),
                  height: 200,
                  padding: const EdgeInsets.all(16),
                ),
                OutlinedButton(
                    onPressed: () {
                      copyToClipboard(state, state.decryptedText);
                    },
                    child: const Text(COPY))
              ],
            ),
          ],
        );
      }),
    );
  }
}

class KeysPage extends StatelessWidget {
  final GlobalState state;
  const KeysPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<GlobalState>(builder: (context, state, widget) {
        return BottomBar(state: state);
      }),
      body: Consumer<GlobalState>(builder: (context, state, widget) {
        return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            navigateToPage(state, 'new-key', 2);
                          },
                          child: const Text(CREATE),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            navigateToPage(state, 'new-key', 2);
                          },
                          child: const Text(IMPORT),
                        )
                      ],
                    )),
                const Text(KEY_LIBRARY, textAlign: TextAlign.left),
                KeyList(state: state),
                const Text(
                  SELECTED_KEYS_INFO,
                  textAlign: TextAlign.left,
                ),
                KeyInfo(selectedKey: state.selectedPGPKey, state: state),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(DELETE),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(COPY),
                    ),
                  ],
                ),
              ],
            ));
      }),
    );
  }
}

class NewKeyPage extends StatelessWidget {
  final GlobalState state;
  const NewKeyPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<GlobalState>(builder: (context, state, widget) {
        return BottomBar(state: state);
      }),
      body: Consumer<GlobalState>(builder: (context, state, widget) {
        return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(CREATE_NEW_PAIR, textAlign: TextAlign.left)),
                NewKeyTable(state: state),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        navigateToPage(state, 'keys', 2);
                      },
                      child: const Text(CANCEL),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        handleOnPressAddNewKey(state);
                      },
                      child: const Text(CREATE),
                    ),
                  ],
                ),
              ],
            ));
      }),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, widget) {
      return Container(
          child: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedFontSize: 14,
        currentIndex: state.currentNavbarIndex,
        onTap: (value) {
          navigateToPage(state, ['encrypt', 'decrypt', 'keys'][value], value);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.password_outlined),
            label: 'Encrypt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Decrypt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.key),
            label: 'Keys',
          ),
        ],
      ));
    });
  }
}

class KeyList extends StatelessWidget {
  const KeyList({Key? key, required state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, widget) {
      return Padding(
          padding: const EdgeInsets.all(8),
          child: Table(
              border: TableBorder.all(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              columnWidths: const {
                1: FractionColumnWidth(.1),
              },
              children: state.keyring.map((e) {
                return TableRow(children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(e.name, textAlign: TextAlign.left)),
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('P', textAlign: TextAlign.center))
                ]);
              }).toList()));
    });
  }
}

class BorderedItem extends StatelessWidget {
  final String title;
  final void Function(String)? onChanged;
  const BorderedItem(
      {Key? key, required this.title, required this.onChanged, required state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, widget) {
      return Container(
          decoration: const BoxDecoration(
            // Red border with the width is equal to 5
            border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.grey),
              vertical: BorderSide(width: 0, color: Colors.grey),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(width: 1, color: Colors.grey)),
                ),
                child: Text(title),
              ),
              Expanded(
                child: SizedBox(
                  child: Padding(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onChanged: onChanged,
                      ),
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0)),
                ),
              ),
            ],
          ));
    });
  }
}

class NewKeyTable extends StatelessWidget {
  const NewKeyTable({Key? key, required state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, widget) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BorderedItem(
                  state: state,
                  title: 'Name',
                  onChanged: (value) {
                    handleUpdateNewKeyDetails(state, 'name', value);
                  }),
              BorderedItem(
                  state: state,
                  title: 'Email',
                  onChanged: (value) {
                    handleUpdateNewKeyDetails(state, 'email', value);
                  }),
              BorderedItem(
                  state: state,
                  title: 'Crypto',
                  onChanged: (value) {
                    handleUpdateNewKeyDetails(state, 'type', value);
                  }),
              BorderedItem(
                  state: state,
                  title: 'Password',
                  onChanged: (value) {
                    handleUpdateNewKeyDetails(state, 'password', value);
                  }),
              BorderedItem(
                  state: state,
                  title: 'Added',
                  onChanged: (value) {
                    handleUpdateNewKeyDetails(state, 'dateAdded', value);
                  }),
            ],
          ));
    });
  }
}

class KeyInfo extends StatelessWidget {
  final PGPKey selectedKey;

  const KeyInfo({Key? key, required this.selectedKey, required state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, widget) {
      if (selectedKey == null) {
        return Container();
      }
      return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BorderedItem(
                  state: state,
                  title: 'Name',
                  onChanged: (value) {
                    handleUpdateNewKeyDetails(state, 'name', value);
                  })
            ],
          ));
    });
  }
}
