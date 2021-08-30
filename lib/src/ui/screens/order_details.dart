import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercommerce/src/res/text_styles.dart';
import 'package:fluttercommerce/src/ui/common/common_button.dart';

class OrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          child: StreamBuilder(
            stream: Firestore.instance.collection("orders").snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 20, bottom: 20, right: 10),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text("Order Number : $index"),
                              Row(
                                children: [
                                  const Text("Order Address"),
                                  Column(children: [
                                    Text(
                                      "  ${snapshot.data.documents[index]['order_address']['address']}",
                                    ),
                                    Text(
                                      "  ${snapshot.data.documents[index]['order_address']['city'] + snapshot.data.documents[index]['order_address']['pincode']}",
                                    ),
                                    Text(
                                        " Name  : ${snapshot.data.documents[index]['order_address']['name']}"),
                                    Text(
                                        " : ${snapshot.data.documents[index]['order_address']['phone_number']}"),
                                  ])
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text("Order items:",
                                  style: AppTextStyles.bold16Color4C4C6F),
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, x) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            " Name:  ${snapshot.data.documents[index]['order_items'][x]['name']}",
                                          ),
                                          const SizedBox(width: 50),
                                          Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(
                                              snapshot.data.documents[index]
                                                  ['order_items'][x]['image'],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        " No .of items:  ${snapshot.data.documents[index]['order_items'][x]['no_of_items']}",
                                      ),
                                      Text(
                                        " Price:  ${snapshot.data.documents[index]['order_items'][x]['price']}",
                                      ),
                                      Text(
                                        " product id:  ${snapshot.data.documents[index]['order_items'][x]['product_id']}",
                                      ),
                                      Text(
                                        " Unit:  ${snapshot.data.documents[index]['order_items'][x]['unit']}",
                                      )
                                    ],
                                  );
                                },
                                itemCount:
                                    // 1
                                    snapshot.data
                                        .documents[index]['order_items'].length,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                " Orderd At:  ${snapshot.data.documents[index]['ordered_at']}",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Payment id:  ${snapshot.data.documents[index]['payment_id']}",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Ordered Status:  ${snapshot.data.documents[index]['order_status']}",
                              ),
                              Text(
                                "order id:  ${snapshot.data.documents[index]['order_id']}",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Total Payment:  ${snapshot.data.documents[index]['price'].toString() + snapshot.data.documents[index]['currency'].toString()}",
                              ),
                              const SizedBox(height: 10),
                              CommonButton(
                                title: "Delete ",
                                buttonColor: Colors.red,
                                onTap: () {
                                  Firestore.instance
                                      .collection("orders")
                                      .document(snapshot.data.documents[index]
                                          ['order_id'])
                                      .delete();
                                },
                              ),
                            ],
                          )),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
