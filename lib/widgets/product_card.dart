import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_mart/constants.dart';
import 'package:v_mart/screens/ProductPage.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final String price;

  ProductCard({this.imageUrl, this.price, this.productId, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              productId: productId,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                  child: Image.network("$imageUrl",
                      height: 260.0, fit: BoxFit.cover),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1.0,
                            blurRadius: 30.0,
                          )
                        ]),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: Constants.normal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(price,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
