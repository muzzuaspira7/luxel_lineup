// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:luxel_lineup/view/all_list.dart';
// import 'package:luxel_lineup/view/products_details.dart';

// class ReusableCartBuilder extends StatefulWidget {
//   String documentNo;
//   String SubCollection;
//   String DressType;

//   ReusableCartBuilder(
//       {super.key,
//       required this.SubCollection,
//       required this.documentNo,
//       required this.DressType});

//   @override
//   State<ReusableCartBuilder> createState() => _ReusableCartBuilderState();
// }

// class _ReusableCartBuilderState extends State<ReusableCartBuilder> {
//   final CollectionReference productsCollection =
//       FirebaseFirestore.instance.collection('products');
//   late String docId = widget.documentNo;
//   late String subColl = widget.SubCollection;
//   late String DressCode = widget.DressType;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 13,
//         ),
//         FutureBuilder<QuerySnapshot>(
//           future: productsCollection.doc(docId).collection(subColl).get(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final shirts = snapshot.data!.docs;

//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   if (shirts[index]['cart'] == true) {
//                     print(shirts[index]['cart']);

//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: InkWell(
//                         onTap: () {
//                           print('Clicked');
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductsDetails(
//                                 SubCollection: subColl,
//                                 documentNo: docId,
//                                 productData: index,
//                                 DressType: DressCode,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.network(
//                               shirts[index]['image'],
//                               scale: 6,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20),
//                               child: SizedBox(
//                                 height: 140,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text(
//                                       shirts[index]['name'],
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 15),
//                                     ),
//                                     Text(
//                                       shirts[index]['description'],
//                                       style: const TextStyle(
//                                         fontFamily: 'DressColorFont',
//                                       ),
//                                     ),
//                                     Text(
//                                       shirts[index]['price'],
//                                       style: const TextStyle(fontSize: 22),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow.shade600,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow.shade600,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow.shade600,
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow.shade600,
//                                         ),
//                                         Icon(
//                                           Icons.star_half,
//                                           color: Colors.yellow.shade600,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Container();
//                   }
//                 },
//                 itemCount: shirts.length,
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxel_lineup/view/products_details.dart';

class ReusableCartBuilder extends StatefulWidget {
  String documentNo;
  String SubCollection;
  String DressType;

  ReusableCartBuilder({
    Key? key,
    required this.SubCollection,
    required this.documentNo,
    required this.DressType,
  }) : super(key: key);

  @override
  State<ReusableCartBuilder> createState() => _ReusableCartBuilderState();
}

class _ReusableCartBuilderState extends State<ReusableCartBuilder> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  late String docId = widget.documentNo;
  late String subColl = widget.SubCollection;
  late String DressCode = widget.DressType;

  late Stream<QuerySnapshot> cartStream;

  @override
  void initState() {
    super.initState();
    cartStream = productsCollection.doc(docId).collection(subColl).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 3,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: cartStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final shirts = snapshot.data!.docs;

              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (shirts[index]['cart'] == true) {
                    print(shirts[index]['cart']);

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                  } else {
                    return Container();
                  }
                },
                itemCount: shirts.length,
              );
            }
          },
        ),
      ],
    );
  }
}
