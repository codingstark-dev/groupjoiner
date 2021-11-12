// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupjoiner/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('RecentAdded')
            .orderBy("GroupCreateAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // ignore: prefer_is_empty
            if (snapshot.data?.docs.length == 0) {
              return const Center(
                child: Text('No Groups Links Are Available'),
              );
            } else {
              return ListView(
                children:
                    List.generate(snapshot.data?.docs.length ?? 0, (index) {
                  return Container(
                      margin: const EdgeInsets.all(8),
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data?.docs[index]['GroupName'] ?? '',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff4cc93d)),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.person),
                                        const SizedBox(width: 5),
                                        Text(
                                          snapshot.data
                                                  ?.docs[index]['GroupType']
                                                  .toString()
                                                  .toUpperCase() ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4cc93d)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 30,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: greenColor),
                                          onPressed: () async {
                                            await canLaunch(snapshot.data
                                                    ?.docs[index]['GroupLink'])
                                                ? await launch(snapshot.data
                                                    ?.docs[index]['GroupLink'])
                                                : throw 'Could not launch ${snapshot.data?.docs[index]['GroupLink']}';
                                          },
                                          child: const Text(
                                            "JOIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
              );
            }
          }
        });
  }
}
