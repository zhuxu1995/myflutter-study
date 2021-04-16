import 'package:flutter/material.dart';

class ListText extends StatelessWidget{
  final List<String> items;
  ListText({Key key,@required this.items}) :super(key: key);
  @override 
  Widget build(BuildContext context){
    return Container(
      child: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return ListTile(
            title: new Text("${items[index]}"),
          );
        },
      ),
    );
  }
}