// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Sellers extends StatefulWidget {
  const Sellers({super.key});

  @override
  State<Sellers> createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("All Sellers"),
      ),
    );
  }
}
