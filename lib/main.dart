import 'package:cart_app/providers/cart_notifier.dart';
import 'package:cart_app/providers/product_notifier.dart';
import 'package:cart_app/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartNotifier()),
      ChangeNotifierProvider(create: (_)=> ProductNotifier())
    ],
    child:  MaterialApp(
      home: const ProductScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    ),
  ));
}
