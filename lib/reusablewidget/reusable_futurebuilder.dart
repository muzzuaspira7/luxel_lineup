import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxel_lineup/view/all_list.dart';
import 'package:luxel_lineup/view/products_details.dart';

class ReusableFutureBuilder extends StatefulWidget {
  String documentNo;
  String SubCollection;
  String DressType;

  ReusableFutureBuilder(
      {super.key,
      required this.SubCollection,
      required this.documentNo,
      required this.DressType});

  @override
  State<ReusableFutureBuilder> createState() => _ReusableFutureBuilderState();
}

class _ReusableFutureBuilderState extends State<ReusableFutureBuilder> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  late String docId = widget.documentNo;
  late String subColl = widget.SubCollection;
  late String DressCode = widget.DressType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DressCode,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => allListWidget(
                              SubCollection: subColl,
                              documentNo: docId,
                              DressType: DressCode)));
                },
                child: const Icon(
                  Icons.arrow_right,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        FutureBuilder<QuerySnapshot>(
          future: productsCollection.doc(docId).collection(subColl).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final shirts = snapshot.data!.docs;
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 200,
                      child: InkWell(
                        onTap: () {
                          print('Clicked');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsDetails(
                                        SubCollection: subColl,
                                        documentNo: docId,
                                        productData: index,
                                        DressType: DressCode,
                                      )));
                        },
                        child: Column(
                          children: [
                            Image.network(
                              shirts[index]['image'],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              shirts[index]['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              shirts[index]['description'],
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Rs ${shirts[index]['price']}',
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
