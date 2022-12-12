import 'package:flutter/material.dart';
import 'package:htp/models/productmodel.dart';

class Detail extends StatelessWidget {
   Detail({super.key,required this.prodetails});
  Products prodetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body:Column(
        children: [
          Image.network(prodetails.image!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Card(child:Container(
              color: Colors.green.shade300,
              child: Column(
                
                children: [
            
              ],),
            ),),
          )
        ],
      )
    );
  }
}
