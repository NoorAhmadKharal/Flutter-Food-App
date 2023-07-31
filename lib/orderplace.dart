import 'package:first_flutter_app/paywithstripe.dart';
import 'package:flutter/material.dart';

class orderplace extends StatefulWidget {
  final String quantity;
  const orderplace({super.key, required this.quantity});

  @override
  State<orderplace> createState() => _orderplaceState();
}

class _orderplaceState extends State<orderplace> {
  @override
  Widget build(BuildContext context) {
    // return Text('${widget.quantity}');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Text("total bill =  ${widget.quantity}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 30))),
              ElevatedButton(
                  onPressed: () {
                    String total = int.parse(widget.quantity).toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => stripe(
                                  payment: total,
                                )));
                  },
                  child: const Text(
                    "Pay with Stripe",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
