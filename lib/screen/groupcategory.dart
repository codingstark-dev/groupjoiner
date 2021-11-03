import 'package:flutter/material.dart';

class GroupCategory extends StatefulWidget {
  const GroupCategory({Key? key}) : super(key: key);

  @override
  _GroupCategoryState createState() => _GroupCategoryState();
}

class _GroupCategoryState extends State<GroupCategory> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        10,
        (index) => Container(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  "https://www.superiorwallpapers.com/images/lthumbs/2017-11/12491_Balls-from-all-sport-Do-sport-all-the-time-HD-wallpaper.jpg",
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 200,
                    height: 30,
                    color: const Color(0xff4cc93d),
                    child: Center(
                      child: Text(
                        "BUSINESS & FINANCE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
