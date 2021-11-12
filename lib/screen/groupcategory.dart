import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupjoiner/screen/category.dart';
import 'package:groupjoiner/utils/constant.dart';

class GroupCategory extends StatefulWidget {
  const GroupCategory({Key? key}) : super(key: key);

  @override
  _GroupCategoryState createState() => _GroupCategoryState();
}

class _GroupCategoryState extends State<GroupCategory> {
  @override
  Widget build(BuildContext context) {
    // get data form firestore og Groups collection and display it in a list view

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Groups").snapshots(),
        builder: (context, snapshot) {
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              snapshot.data?.docs.length ?? 0,
              (index) {
                var image = snapshot.data?.docs[index].data() as Map;
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryGroups(
                                  category: snapshot.data?.docs[index].id
                                      as String)));
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          image['imageurl'] ??
                              "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081",
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 200,
                            height: 30,
                            color: greenColor,
                            child: Center(
                              child: Text(
                                snapshot.data?.docs[index].id.toUpperCase() ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
