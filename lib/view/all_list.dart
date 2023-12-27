import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxel_lineup/view/products_details.dart';

class allListWidget extends StatefulWidget {
  String documentNo;
  String SubCollection;
  String DressType;

  allListWidget({
    Key? key,
    required this.SubCollection,
    required this.documentNo,
    required this.DressType,
  }) : super(key: key);

  @override
  State<allListWidget> createState() => _allListWidgetState();
}

class _allListWidgetState extends State<allListWidget> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  late String docId = widget.documentNo;
  late String subColl = widget.SubCollection;
  late String DressCode = widget.DressType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DressCode),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: productsCollection.doc(docId).collection(subColl).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error:${snapshot.error}');
          } else {
            final shirts = snapshot.data!.docs;

            return ListView.builder(
              itemBuilder: (context, index) {
                // var shirt = shirts[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          shirts[index]['image'],
                          scale: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            height: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  shirts[index]['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  shirts[index]['description'],
                                  style: const TextStyle(
                                    fontFamily: 'DressColorFont',
                                  ),
                                ),
                                Text(
                                  shirts[index]['price'],
                                  style: const TextStyle(fontSize: 22),
                                ),
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
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: shirts.length,
            );
         
          }
        },
      ),
    );
  }
}
