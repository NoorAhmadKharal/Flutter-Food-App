import 'package:first_flutter_app/order.dart';
import 'package:flutter/material.dart';

class DisplayMenu extends StatefulWidget {
  DisplayMenu({Key? key}) : super(key: key);

  @override
  _DisplayMenuState createState() => _DisplayMenuState();
}

class _DisplayMenuState extends State<DisplayMenu> {
  List<dynamic> data = [
    {
      "image":
          'https://w7.pngwing.com/pngs/686/527/png-transparent-fast-food-hamburger-sushi-pizza-fast-food-food-breakfast-fast-food-restaurant.png',
      "name": 'Burger',
      "price": '500',
    },
    {
      "image":
          'https://w7.pngwing.com/pngs/692/99/png-transparent-hamburger-street-food-seafood-fast-food-delicious-food-salmon-with-vegetables-salad-in-plate-leaf-vegetable-food-recipe-thumbnail.png',
      "name": 'vegetable',
      "price": '200',
    },
    {
      "image":
          'https://img.freepik.com/free-photo/big-tasty-burger-with-fries_144627-24415.jpg?w=2000',
      "name": 'Burger',
      "price": '300',
    },
    {
      "image":
          'https://assets.stickpng.com/images/580b57fbd9996e24bc43c0cc.png',
      "name": 'chicken',
      "price": '400',
    },
    {
      "image":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD61ANlMO2tfSFgvBCSoRmSXAA5u5oe7Mlfw&usqp=CAU',
      "name": 'Deal',
      "price": '500',
    },
    {
      "image":
          'https://e7.pngegg.com/pngimages/339/456/png-clipart-mcdonald-s-combo-meal-mcdonald-s-chicken-mcnuggets-fizzy-drinks-mcdonald-s-big-mac-hamburger-coca-cola-mcdonalds-food-breakfast.png',
      "name": 'Deal',
      "price": '600',
    },
    {
      "image":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwKme4o4VHGviw4Dnv6x4EyKTt3_Iso3swuQ&usqp=CAU',
      "name": 'Deal',
      "price": '700',
    },
    {
      "image": 'https://cdn7.kiwilimonrecipes.com/brightcove/8634/8634.jpg',
      "name": 'sandwich',
      "price": '800',
    },
    {
      "image":
          'https://recipes.timesofindia.com/thumb/83740315.cms?width=1200&height=900',
      "name": 'sandwich',
      "price": '900',
    }
  ];

  List<dynamic> filteredData = [];
  Set<String> selectedCategories = Set<String>();
  TextEditingController searchController = TextEditingController();

  List<String> categories = ['Burger', 'sandwich', 'Vegetable'];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(data);
  }

  void searchProducts(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredData = data
          .where((deal) => deal['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category.toLowerCase())) {
        selectedCategories.remove(category.toLowerCase());
      } else {
        selectedCategories.add(category.toLowerCase());
      }
      filterData();
    });
  }

  void filterData() {
    setState(() {
      if (selectedCategories.isEmpty) {
        filteredData = List.from(data);
      } else {
        filteredData = data
            .where((deal) =>
                selectedCategories.contains(deal['name'].toLowerCase()))
            .toList();
      }
    });
  }

  bool isItemSelected(String category) {
    return selectedCategories.contains(category.toLowerCase());
  }

  void placeOrder(String imageUrl, String itemName, String itemPrice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => order(
          uRlimage: imageUrl,
          price: itemPrice,
          itemname: itemName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchProducts(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 5.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: categories.map((category) {
              return FilterChip(
                label: Text(category),
                selected: isItemSelected(category),
                onSelected: (isSelected) {
                  toggleCategory(category);
                },
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(item: item),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Image.network(item['image']),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          placeOrder(
                              item['image'], item['name'], item['price']);
                        },
                        child: Text('Place Order'),
                      ),
                      Text(item['name']),
                      Text('Price: ${item['price']}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final dynamic item;

  OrderPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.network(item['image']),
          ),
          Text(item['name']),
          Text('Price: ${item['price']}'),
          ElevatedButton(
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     // return AlertDialog(
              //     //   title: Text('Order Placed'),
              //     //   content: Text('Your order has been placed successfully.'),
              //     //   actions: [
              //     //     TextButton(
              //     //       onPressed: () {
              //     //         Navigator.of(context).pop();
              //     //       },
              //     //       child: Text('OK'),
              //     //     ),
              //     //   ],
              //     // );
              //   },
              // );
            },
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DisplayMenu(),
  ));
}
