import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shopping_list.dart';
import 'package:flutter_application_1/utils/dbhelper.dart';

class ShoppingListDialog{
  
  final textName = TextEditingController();
  final textPriority = TextEditingController();

  Widget buildDialog(BuildContext context,  ShoppingList shoppingList, bool isNew){
    DbHelper dbHelper = DbHelper();

    if (!isNew){
      textName.text = shoppingList.name;
      textPriority.text = shoppingList.priority.toString();
    }
    else {
      textName.text = "";
      textPriority.text = "";
    }

      return AlertDialog(
      title: Text((isNew)? "New Shopping list": "Editing Shopping list"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: textName,
              decoration: const InputDecoration(
                hintText: "Shopping list name",
              ),
            ),
            TextField(
              controller: textPriority,
              decoration: const InputDecoration(
                hintText: "Shopping list priority",
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                shoppingList.name = textName.text;
                shoppingList.priority = int.parse(textPriority.text);
                await dbHelper.insertList(shoppingList);
                Navigator.pop(context);
              },
              child: const Text("Save shopping list")
            )
          ]
        ),
      ),
    );

  }
}