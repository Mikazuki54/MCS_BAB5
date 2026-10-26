import 'package:flutter/material.dart';

class CustomReadField extends StatelessWidget {
  String hasil;
  Color warnaBorder;
  String gambar;

  CustomReadField({
    super.key,
    required this.hasil,
    required this.warnaBorder,
    required this.gambar,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: warnaBorder, width: 4),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 4,
            child: Image.asset(gambar, fit: BoxFit.fill),
          ),
          const SizedBox(height: 14),
          Center(child: Text(hasil)),
        ],
      ),
    );
  }
}