
import 'package:flutter/material.dart';
import 'package:flutter_app_burguers/burgers_provider.dart';
import 'package:flutter_app_burguers/burgers_store_bloc.dart';
import 'package:flutter_app_burguers/burgers_store_list.dart';
import 'package:flutter_app_burguers/burgues_store_cart.dart';

const _backgroundColor = Color(0xFFDEDED9);
const cartBarHeight = 200.0;
const _panelTransition = Duration(milliseconds: 500);

class BurguersHome extends StatefulWidget {
  const BurguersHome({super.key});

  @override
  State<BurguersHome> createState() => _BurguersHomeState();
}

class _BurguersHomeState extends State<BurguersHome> {

  final bloc = BurgerStoreBloC();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta! > 7) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(BurgersState state, Size size) {
    if (state == BurgersState.normal) {
      return -cartBarHeight;
    } else if (state == BurgersState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeight / 2);
    } else {
      return 0.0;
    }
  }

  double _getTopForBlackPanel(BurgersState state, Size size) {
    if (state == BurgersState.normal) {
      return size.height - kToolbarHeight - cartBarHeight;
    } else if (state == BurgersState.cart) {
      return cartBarHeight / 2;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BurgersProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) { 
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  _AppBarBurgersHome(),
                  Expanded(    
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: _panelTransition,
                          curve: Curves.decelerate,
                          left: 0,
                          right: 0,
                          top: _getTopForWhitePanel(bloc.burgersState, size),
                          height: size.height - kToolbarHeight,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: const BurgersStoreList(),
                            ),
                          ) 
                        ),
                        AnimatedPositioned(
                          duration: _panelTransition,
                          curve: Curves.decelerate,
                          left: 0,
                          right: 0,
                          top: _getTopForBlackPanel(bloc.burgersState, size),
                          height: size.height - kToolbarHeight,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: bloc.burgersState == BurgersState.normal ? Row(
                                      children: [                                       
                                        const Text(
                                          'Cart',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: AnimatedSwitcher(
                                              duration: _panelTransition,
                                              child: Row(
                                                children: List.generate(
                                                  bloc.cart.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Hero(
                                                      tag: 'list_${bloc.cart[index].product.name}details',
                                                      child: CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                          bloc.cart[index].product.image,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                )                                                    
                                              )
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.yellow,
                                          child: Text(bloc.totalProducts().toString()),
                                        )
                                      ],
                                    ) : const SizedBox.shrink(),
                                  ),
                                  BurgersStoreCart(),
                                ],
                              )
                            ),
                          ) 
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
         },
      ),
    );
  }
}

class _AppBarBurgersHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: _backgroundColor,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Expanded(
            child: Text(
              'Burges and Extras',
              style: TextStyle(
                color: Colors.black,
              ), 
            )
          ),
          // const IconButton(
          //   onPressed: () => null,
          //   icon: Icon(Icons.settings)
          // )
        ],
      ),
    );
  }
}