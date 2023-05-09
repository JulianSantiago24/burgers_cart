import 'package:flutter/material.dart';
import 'package:flutter_app_burguers/burgers_home.dart';
import 'package:flutter_app_burguers/burgers_products_details.dart';
import 'package:flutter_app_burguers/burgers_provider.dart';

class BurgersStoreList extends StatelessWidget {
  const BurgersStoreList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BurgersProvider.of(context)!.bloc;
    return ListView.builder(
      padding: const EdgeInsets.only(top: cartBarHeight),
      itemCount: bloc.catalog.length,
      itemBuilder: (context, index){
        final product = bloc.catalog[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, __){
                  return FadeTransition(
                    opacity: animation, 
                    child: BurgersProductsDetails(
                      product: product,
                      onProductAdded: (){
                        bloc.addProduct(product, context);
                      }
                    ),
                  );
                }
              )
            );
          },
          child: Container(
            color: Colors.black,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(children: [
                    Hero(
                      tag: 'list_${product.name}',
                      child: Image.asset(
                      product.image,
                      fit: BoxFit.fitWidth,              
                                      ),
                    ),
                  Column(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30
                        ),
                      ),
                      Text(
                        product.name,
                        style: const TextStyle(
                          backgroundColor: Colors.blue,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25
                        ),
                      ),
                    ],
                  )
                  ],)
                ],
            ),
          ),
        );
      }
    );
  }
}