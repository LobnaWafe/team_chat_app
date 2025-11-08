import 'package:chats_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      height: 45, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center( 
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center, 
          style: const TextStyle(fontSize: 16,color: Colors.grey),
          decoration: InputDecoration(
            hintText: S.of(context).Search,
            hintStyle: const TextStyle(

              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold, 
            ),
            prefixIcon:
                const Icon(Icons.search, color: Colors.grey, size: 25),
            border: InputBorder.none,
            isDense: true, 
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0, 
              horizontal: 10,
            ),
          ),
        ),
      ),
    );
  }
}
