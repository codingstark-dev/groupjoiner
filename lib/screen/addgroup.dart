import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  String _chosenValue = "Android";

  @override
  Widget build(BuildContext context) {
//  create textinput field for group name

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
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
            child: TextFormField(
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
                hintText: 'Enter Group Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Material(
            elevation: 2,
            child: TextFormField(
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
        Center(
          child: Container(
            padding: const EdgeInsets.all(0.0),
            child: DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: const TextStyle(color: Colors.black),

              items: <String>[
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                'PHP',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text(
                "Please choose a langauage",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (dynamic value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff4cc93d),
                fixedSize: Size(100, 40)),
            onPressed: () {},
            child: const Text(
              "ADD GROUP",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
