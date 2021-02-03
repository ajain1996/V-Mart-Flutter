import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_mart/constants.dart';
import 'package:v_mart/screens/CartPage.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;

  CustomActionBar({this.title, this.hasBackArrow, this.hasTitle});

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white,
      ])),
      padding:
          EdgeInsets.only(top: 42.0, left: 24.0, bottom: 18.0, right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  color: Colors.white,
                  width: 14.0,
                  height: 14.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.regularHeading,
            ),
          Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  child: Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 26,
                      ),
                      StreamBuilder(
                          stream: _usersRef
                              .doc(_user.uid)
                              .collection("Cart")
                              .snapshots(),
                          builder: (context, snapshot) {
                            int _totalItems = 0;

                            //just add this line
                            if (snapshot.data == null)
                              return CircularProgressIndicator();

                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              List _documents = snapshot.data.docs;
                              _totalItems = _documents.length;
                            }
                            return Container(
                              width: 20.0,
                              height: 20.0,
                              margin: EdgeInsets.only(bottom: 20.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Text(
                                '$_totalItems' ?? '0',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
