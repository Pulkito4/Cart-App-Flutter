import 'package:cart_app/data/products.data.dart';
import 'package:cart_app/providers/cart_notifier.dart';
import 'package:cart_app/providers/product_notifier.dart';
import 'package:cart_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartNotifier>(context);
    var prodProvider = Provider.of<ProductNotifier>(context); 
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Electronics Store',
            // style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          leading: const Icon(
            Icons.shopify,
            size: 50,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            ),
          ],
        ),
        body: Column(
          
          children: [
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search Products",
                        ),
                        onChanged: (value) {
                          prodProvider.search(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  
                  children: [
                    const Icon(
                      Icons.filter_list_alt,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                        value: prodProvider.dropdownValue,
                        items: const [
                          DropdownMenuItem(
                            value: "priceDesc",
                            child: Text("Price: High-to-Low"),
                          ),
                          DropdownMenuItem(
                            value: "priceAsc",
                            child: Text("Price: Low-to-High"),
                          ),
                          DropdownMenuItem(
                            value: "default",
                            child: Text("No Filter"),
                          )
                        ],
                        onChanged: (value) {
                          prodProvider.dropdownValue = value!;
                          if (value == "priceDesc") {
                            prodProvider.sortDesc();
                          }
                          if (value == "priceAsc") {
                            prodProvider.sortAsc();
                          }
                          if (value == "default") {
                            prodProvider.sortDefault();
                          }
                        }),
                  ],
                ),
              ],
            )),
            Container(
                child: Expanded(
              child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    /* return ListTile(
                        leading: Image.network(productList[index].p_image),
                      ); */
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Card(
                        child: Row(
                          children: [
                            Image.network(
                              prodProvider.searchList[index].p_image,
                              width: MediaQuery.of(context).size.width * 0.45,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      prodProvider.searchList[index].p_name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.abhayaLibre(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Price: ₹${prodProvider.searchList[index].p_price}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.abhayaLibre(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      cartProvider.addToCart(index);
                                    },
                                    icon: const Icon(Icons.add_shopping_cart),
                                    label: const Text("Add to Cart"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )),
          ],
        ));
  }
}
