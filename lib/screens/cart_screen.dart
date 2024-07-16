import 'package:cart_app/providers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.shopify,
              size: 40,
            ),
          ),
          title: Text(
            'Cart',
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        body: cartProvider.cartList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Cart is Empty",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Browse Products",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              )
            : ListView.builder(
                itemCount: cartProvider.cartList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(children: [
                      Column(
                        children: [
                          Image.network(
                            cartProvider.cartList[index].productImage,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                cartProvider.removeFromCart(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              cartProvider.cartList[index].productName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Qty: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton.outlined(
                                    onPressed: () {
                                      cartProvider.increaseQuantity(index);
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(cartProvider
                                    .cartList[index].productQuantity
                                    .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton.outlined(
                                    onPressed: () {
                                      cartProvider.decreaseQuantity(index);
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.blue,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Amount: ₹${cartProvider.cartList[index].productAmount.toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {}, // No checkout page made as this is only a UI
            // only cart functionality is implemented in this app
            child: const Text(
              "Proceed to Checkout",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
          ),
        ));
  }
}
