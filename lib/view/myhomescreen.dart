import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxel_lineup/reusablewidget/reusable.dart';
import 'package:luxel_lineup/reusablewidget/reusableCart.dart';
import 'package:luxel_lineup/reusablewidget/reusable_futurebuilder.dart';
import 'package:luxel_lineup/reusablewidget/reusableCart.dart';
import 'package:luxel_lineup/view/addtocart.dart';
import 'carousel.dart';
import 'drawer.dart';
import 'all_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  late String docId = '1';
  late String subColl = 'shirts';
  late String DressCode = 'Shirts for You';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E5DE),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'LuxeLineup',
              style: TextStyle(fontFamily: 'MainFont'),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addToCartPage()));
              },
              child: const Icon(
                Icons.shopping_cart,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.camera_alt_rounded),
                    SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          contentPadding: EdgeInsets.only(top: 30, bottom: 5),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      height: 30,
                      width: 250,
                    ),
                    Icon(Icons.search),
                    Icon(Icons.mic),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  reusableWidget()
                      .ReusableRowColumn("assets/images/shirt.jpg", "Shirts"),
                  reusableWidget().ReusableRowColumn(
                      "assets/images/t-shirt.jpg", "T-Shirt"),
                  reusableWidget()
                      .ReusableRowColumn("assets/images/hoodie.jpg", "Hoodie"),
                  reusableWidget()
                      .ReusableRowColumn("assets/images/pant.jpg", "Pants"),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Carousel
            const carousel(),
            const SizedBox(height: 15),
            // GridView for shirts
            ReusableFutureBuilder(
              SubCollection: 'shirts',
              documentNo: '1',
              DressType: 'Shirts for You',
            ),
            const SizedBox(
              height: 13,
            ),
            // Heading and Gridview for t-shirts
            ReusableFutureBuilder(
              SubCollection: 't-shirts',
              documentNo: '2',
              DressType: 'T-Shirts for You',
            ),
            const SizedBox(height: 13),
            //Heading and Gridview for hoodies
            ReusableFutureBuilder(
                SubCollection: 'hoodies',
                documentNo: '3',
                DressType: 'Hoodies for You'),
            const SizedBox(
              height: 13,
            ),
            //Heading and Gridview for pants
            ReusableFutureBuilder(
                SubCollection: 'pants',
                documentNo: '4',
                DressType: 'Pants for You'),
            const SizedBox(
              height: 13,
            ),
          ],
        ),
      ),
    );
  }
}
