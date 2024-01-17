import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

class ProductsDetails extends StatefulWidget {
  final String documentNo;
  final String SubCollection;
  final String DressType;
  final num productData;

  const ProductsDetails({
    Key? key,
    required this.documentNo,
    required this.SubCollection,
    required this.DressType,
    required this.productData,
  }) : super(key: key);

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  bool isAddedToCart = false;

  @override
  void initState() {
    super.initState();
    fetchCartState();
  }

  void fetchCartState() async {
    try {
      var docId = widget.documentNo;
      var subCollection = widget.SubCollection;
      var subDocId = widget.productData.toInt() + 1; // Adjust the ID

      var snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId.toString())
          .get();

      if (snapshot.exists) {
        var cartState = snapshot['cart'];
        setState(() {
          isAddedToCart = cartState ?? false;
        });
      }
    } catch (e) {
      print("Error fetching cart state: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var documentNumber = widget.documentNo;
    var dressCollection = widget.SubCollection;
    var dressId = widget.productData.toInt();
    final CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('products');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.DressType),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: productsCollection
            .doc(documentNumber)
            .collection(dressCollection)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final shirts = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FanCarouselImageSlider(
                      imagesLink: [
                        shirts[dressId]['s1image'],
                        shirts[dressId]['s2image'],
                        shirts[dressId]['s3image'],
                      ],
                      isAssets: false,
                      autoPlay: false,
                      isClickable: false,
                      sidesOpacity: 0.5,
                      sliderHeight: 360,
                      indicatorActiveColor: Colors.black,
                      currentItemShadow: const [
                        BoxShadow(spreadRadius: 0, blurRadius: 0)
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      shirts[dressId]['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.yellow.shade600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Color: ',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'DressColorFont'),
                        ),
                        Text(
                          shirts[dressId]['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DressColorFont',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFE2E5DE),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Special Offer',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Row(
                              children: [
                                const Text(
                                  '36% Off',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(164, 0, 0, 0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '₹ ${shirts[dressId]['price']}',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {}, child: const Text('S')),
                        OutlinedButton(
                            onPressed: () {}, child: const Text('M')),
                        OutlinedButton(
                            onPressed: () {}, child: const Text('L')),
                        OutlinedButton(
                            onPressed: () {}, child: const Text('XL')),
                        OutlinedButton(
                            onPressed: () {}, child: const Text('XXL')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 155,
                          child: ElevatedButton(
                            onPressed: () {
                              print(documentNumber);
                              print(dressCollection);
                              print(dressId);

                              _addToCart(documentNumber, dressCollection,
                                  dressId + 1, !isAddedToCart);

                              setState(() {
                                isAddedToCart = !isAddedToCart;
                              });
                            },
                            child: Text(
                              isAddedToCart ? 'Remove Cart' : 'Add To Cart',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: const Color(0xFFE2E5DE),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 155,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Clicked on Buy Now');
                            },
                            child: const Text(
                              'Buy Now',
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _addToCart(
      String docId, String subCollection, int subDocId, bool addToCart) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId.toString())
          .update({'cart': addToCart});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          addToCart
              ? "Successfully Added to Cart"
              : "Successfully Removed from Cart",
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          right: 20,
          left: 20,
        ),
      ));
    } catch (e) {
      print("Error handling cart action: $e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error handling Cart action"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          right: 20,
          left: 20,
        ),
      ));
    }
  }
}
