import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxel_lineup/reusablewidget/reusableCart.dart';

class addToCartPage extends StatefulWidget {
  const addToCartPage({super.key});

  @override
  State<addToCartPage> createState() => _addToCartPageState();
}

class _addToCartPageState extends State<addToCartPage> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  late String docId = '1';
  late String subColl = 'shirts';
  late String DressCode = 'Shirts for You';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Carts'),
      ),
      body: Column(
        children: [
          ReusableCartBuilder(
            SubCollection: 'shirts',
            documentNo: '1',
            DressType: 'Shirts for You',
          ),
          ReusableCartBuilder(
            SubCollection: 't-shirts',
            documentNo: '2',
            DressType: 'T-Shirts for You',
          ),
          const SizedBox(height: 13),
          ReusableCartBuilder(
              SubCollection: 'hoodies',
              documentNo: '3',
              DressType: 'Hoodies for You'),
        ],
      ),
    );
  }
}
