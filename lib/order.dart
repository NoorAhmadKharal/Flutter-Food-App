import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_flutter_app/orderplace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class order extends StatefulWidget {
  final String uRlimage;
  final String price;
  final String itemname;

  const order(
      {super.key,
      required this.uRlimage,
      required this.price,
      required this.itemname});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  final quantity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Image.network("${widget.uRlimage}"),
          // const Text(" Item name : Pizza ",
          //     style: TextStyle(color: Colors.white, fontSize: 30)),
          Text(" ${widget.itemname} : price =${widget.price}",
              style: const TextStyle(color: Colors.white, fontSize: 30)),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 250,
            child: TextFormField(
              controller: quantity,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                fillColor: Colors.cyan,
                filled: true,
                hintText: "Add Quantity ",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                final int bill;
                bill = int.parse(widget.price) * int.parse(quantity.text);

                ordertable(
                    itemname: widget.itemname,
                    quantity: quantity.text,
                    bill: bill.toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            orderplace(quantity: bill.toString())));
              },
              child: const Text("Order place")),
        ]),
      ),
    ));
  }

  Future ordertable({
    required String itemname,
    required String quantity,
    required String bill,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('ordertable')
        .add({'itemname': itemname, 'quantity': quantity, 'bill': bill});
    final taskId = documentReference.id;
    await FirebaseFirestore.instance
        .collection('ordertable')
        .doc(taskId)
        .update({'id': taskId});
  }
}
