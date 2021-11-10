import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupjoiner/utils/constant.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:uuid/uuid.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  String _chosenValue = "News & Politics";

  var uuid = const Uuid();

// create textfield controller for group name
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupLinkController = TextEditingController();
  bool groupText = false;
  bool grouplink = false;
  final filter = ProfanityFilter();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "-: Add Group Details :-",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff4cc93d)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            elevation: 2,
            child: TextField(
              controller: _groupNameController,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                focusColor: Colors.white,
                disabledBorder: const UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4cc93d)),
                ),
                hintText: 'Enter Group Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Material(
            elevation: 2,
            child: TextField(
              controller: _groupLinkController,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                focusColor: Colors.white,
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4cc93d)),
                ),
                hintText: 'Enter Group Link',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "CHOOSE CATEGORY :-",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xff4cc93d)),
        ),
        FutureBuilder<dynamic>(
          future: FirebaseFirestore.instance.collection('Groups').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return DropdownButton(
                value: _chosenValue,
                // icon: Icon(Icons.arrow_drop_down_circle_sharp),
                iconSize: 24,
                elevation: 16, iconEnabledColor: greenColor,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: greenColor,
                ),
                onChanged: (dynamic newValue) {
                  setState(() {
                    _chosenValue = newValue;
                  });
                },
                hint: const Text(
                  "Please choose a langauage",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                items: snapshot.data?.docs.map<DropdownMenuItem<String>>(
                  (DocumentSnapshot value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Text(value.id),
                    );
                  },
                ).toList(),
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: greenColor, fixedSize: const Size(100, 40)),
            onPressed: () {
              setState(() {
                groupText = true;
              });
              // FirebaseFirestore.instance
              //     .collection('Groups')
              //     .doc(_groupNameController.text)
              //     .set({
              //   'GroupName': _groupNameController.text,
              //   'GroupLink': _groupLinkController.text,
              //   'GroupType': _chosenValue,
              // });
              bool grouplinkvalid = _groupLinkController.text
                  .contains("https://chat.whatsapp.com/");
              bool _validURL = Uri.parse(_groupLinkController.text).isAbsolute;

              if (_groupNameController.text.isEmpty ||
                  _groupLinkController.text.isEmpty ||
                  _chosenValue.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding:
                            const EdgeInsets.fromLTRB(22, 10, 10, 10),
                        title: const Text(
                          "Error!!!!",
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(_groupNameController.text.isEmpty
                            ? "Group Name is Empty"
                            : "Group link is Empty"),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: greenColor),
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              } else {
                if (filter.hasProfanity(_groupNameController.text)) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding:
                              const EdgeInsets.fromLTRB(22, 10, 10, 10),
                          title: const Text(
                            "Error!!!!",
                            style: TextStyle(color: Colors.red),
                          ),
                          content: const Text(
                              "Please don't use illegal word in group name"),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: greenColor),
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                } else {
                  print(_validURL);
                  if (!_validURL) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding:
                                const EdgeInsets.fromLTRB(22, 10, 10, 10),
                            title: const Text(
                              "Error!!!!",
                              style: TextStyle(color: Colors.red),
                            ),
                            content: const Text("Please Enter Valid Url"),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: greenColor),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  } else {
                    if (!grouplinkvalid) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(22, 10, 10, 10),
                              title: const Text(
                                "Error!!!!",
                                style: TextStyle(color: Colors.red),
                              ),
                              content:
                                  const Text("Please Enter Valid WhatsApp Url"),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: greenColor),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      final sameUid = uuid.v4();
                      FirebaseFirestore.instance
                          .collection('Groups')
                          .doc(_chosenValue)
                          .collection("links")
                          .doc(sameUid)
                          .set({
                        'GroupName': _groupNameController.text,
                        'GroupLink': _groupLinkController.text,
                        'GroupType': _chosenValue,
                        "GroupCreateAt": DateTime.now(),
                        "uid": sameUid
                      }).then((value) => {
                                _groupLinkController.clear(),
                                _groupNameController.clear(),
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                22, 10, 10, 10),
                                        title: const Text(
                                          "Done!!!!",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        // content: const Text(
                                        //     "Please Enter Valid WhatsApp Url"),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: greenColor),
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    })
                              });
                      FirebaseFirestore.instance
                          .collection("RecentAdded")
                          .doc(sameUid)
                          .set({
                        'GroupName': _groupNameController.text,
                        'GroupLink': _groupLinkController.text,
                        'GroupType': _chosenValue,
                        "GroupCreateAt": DateTime.now(),
                        "uid": sameUid
                      });
                    }
                  }
                }
              }
              // print(_validURL);
              print({
                _groupLinkController.text,
                _groupNameController.text,
                _chosenValue
              });
            },
            child: const Text(
              "ADD GROUP",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
