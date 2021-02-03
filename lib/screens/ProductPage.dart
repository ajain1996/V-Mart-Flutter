import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_mart/constants.dart';
import 'package:v_mart/services/firebase_services.dart';
import 'package:v_mart/widgets/custom_action_bar.dart';
import 'package:v_mart/widgets/image_swipe.dart';
import 'package:v_mart/widgets/product_size.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  bool _registerFormLoading = false;

  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future _addToCart() {
    setState(() {
      widget._registerFormLoading = false;
    });

    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});

    setState(() {
      widget._registerFormLoading = true;
    });
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBarAddToCard =
      SnackBar(content: Text('Product added to the Cart'));

  final SnackBar _snackBarAddToSaved =
      SnackBar(content: Text('Product added to the Saved'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _firebaseServices.productsRef.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  // Firebase Document Data Map
                  Map<String, dynamic> documentData = snapshot.data.data();

                  // List of images
                  List imageList = documentData['images'];
                  List productSizes = documentData['size'];

                  // Set an initial size
                  _selectedProductSize = productSizes[0];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: 100.0, bottom: 30.0),
                      children: [
                        ImageSwipe(
                          imageList: imageList,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, bottom: 8.0, left: 24.0, right: 24.0),
                          child: Text(
                            "${documentData['name']}" ?? 'Product Name',
                            style: Constants.boldHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          child: Text(
                            "${documentData['price']}" ?? 'Product Price',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          child: Text(
                            "${documentData['desc']}" ?? 'Product Desc',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "Select Size",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ProductSize(
                          productSizes: productSizes,
                          onSelected: (size) {
                            _selectedProductSize = size;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _addToSaved();
                                  Scaffold.of(context)
                                      .showSnackBar(_snackBarAddToSaved);
                                },
                                child: Container(
                                  width: 65.0,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdcdcdc),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(
                                      "assets/images/tab_saved.png",
                                    ),
                                    height: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await _addToCart();
                                    Scaffold.of(context)
                                        .showSnackBar(_snackBarAddToCard);
                                  },
                                  child: Container(
                                    height: 65.0,
                                    margin: EdgeInsets.only(left: 16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Visibility(
                                          visible: widget._registerFormLoading
                                              ? false
                                              : true,
                                          child: Text(
                                            'Add to cart',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Visibility(
                                          visible: widget._registerFormLoading,
                                          child: Center(
                                            child: SizedBox(
                                                height: 30.0,
                                                width: 30.0,
                                                child:
                                                    CircularProgressIndicator()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }

                // Loading state
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
          )
        ],
      ),
    );
  }
}
