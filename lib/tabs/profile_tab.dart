import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image(
          image: AssetImage('assets/images/logo.png'),
          width: 115.0,
          height: 50.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 300.0,
            child: Image(
              image: AssetImage("assets/images/user.png"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(24.0),
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1.0,
                    blurRadius: 30.0,
                  )
                ]),
            child: Center(
              child: Text(
                '${_user.email}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Container(
              margin: EdgeInsets.only(top: 40.0, left: 4.0, right: 4.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1.0,
                      blurRadius: 30.0,
                    )
                  ]),
              child: Center(
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
