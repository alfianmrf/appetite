import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;

  const SearchBoxWidget({
    Key? key,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: 'What are you looking for?',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        fillColor: Colors.white.withOpacity(0.5),
        filled: true,
      ),
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      onChanged: (val) {
        onChanged!(val);
      },
    );
  }
}
