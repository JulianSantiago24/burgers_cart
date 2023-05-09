
import 'package:flutter/material.dart';
import 'package:flutter_app_burguers/burgers_products.dart';

class BurgersProductsDetails extends StatefulWidget {
  const BurgersProductsDetails({
    super.key,
    required this.product,
    required this.onProductAdded
  });

  final BurgersProduct product;
  final VoidCallback onProductAdded;

  @override
  State<BurgersProductsDetails> createState() => _BurgersProductsDetailsState();
}

class _BurgersProductsDetailsState extends State<BurgersProductsDetails> {
  
  String heroTag = '';
  
  void _addToCart(BuildContext context) {
    setState(() {
      heroTag = 'details';
    });
    widget.onProductAdded();
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [                
                Hero(
                  tag: 'list_${widget.product.name}$heroTag',
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [                    
                      Text(
                        '\$${widget.product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        )
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _addToCart(context),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),                     
                    ),
                  )
                ],
              ),
           ),
        ],
      )
    );
  }
}