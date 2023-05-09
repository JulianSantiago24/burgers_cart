
class BurgersProduct {
  const BurgersProduct({
    required this.price,
    required this.name,
    required this.image,
  });
  final double price;
  final String name;
  final String image;
}

const burgersProducts = <BurgersProduct>[
  BurgersProduct(price: 5.00, name: 'X Burger', image: 'assets/images/burger.jpg'),
  BurgersProduct(price: 4.50, name: 'X Egg', image: 'assets/images/burger_egg.jpg'),
  BurgersProduct(price: 7.00, name: 'X Bacon', image: 'assets/images/burger_bacon.jpg'),
  BurgersProduct(price: 2.00, name: 'Fries', image: 'assets/images/fries.jpg'),
  BurgersProduct(price: 2.50, name: 'Soft Drink', image: 'assets/images/soft_drink.jpg'),
];
