

import 'package:flutter/material.dart';
import 'package:flutter_app_burguers/burgers_provider.dart';
import 'package:flutter_app_burguers/burgers_store_bloc.dart';

class BurgersStoreCart extends StatefulWidget {

  @override
  State<BurgersStoreCart> createState() => _BurgersStoreCartState();
}

class _BurgersStoreCartState extends State<BurgersStoreCart> {
  @override
  Widget build(BuildContext context) {
    final bloc = BurgersProvider.of(context)!.bloc;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Column(
            children: [
              bloc.burgersState == BurgersState.normal ? const Icon(Icons.arrow_circle_down, color: Colors.white,): const Icon(Icons.arrow_circle_up, color: Colors.white,),
              const SizedBox(height: 100),
              const Text(
                'Cart',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white
                ),
              ),             
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 28
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${bloc.totalPriceProducts()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Discount',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18
                          ),
                        ),
                        const Spacer(),
                        Text(
                          bloc.discountPriceProducts(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                final snackBar = SnackBar(
                  content: const Text('Successful Transaction!'),
                  action: SnackBarAction(
                    label: 'Done',
                    onPressed: () {},
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    bloc.burgersState = BurgersState.normal;
                    bloc.cart.clear();
                  });
                  },
                child: const Text(
                  'Pay',
                ),                     
              ),
            ],
          ),
        ],
      ),
    );
  }
}