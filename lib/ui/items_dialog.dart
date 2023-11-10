import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_items.dart';
import 'package:flutter_application_1/models/shopping_list.dart';
import 'package:flutter_application_1/utils/dbhelper.dart';

class ItemsDialog {
  final textName = TextEditingController();
  final textQuantity = TextEditingController();
  final textNote = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList shoppingList,
      ListItems listItems, bool isNew) {
    DbHelper dbHelper = DbHelper();

    if (!isNew) {
      textName.text = listItems.name;
      textQuantity.text = listItems.quantity;
      textNote.text = listItems.note;
    } else {
      textName.text = "";
      textQuantity.text = "";
      textNote.text = "";
    }

    return AlertDialog(
      title: Text((isNew) ? "New item" : "Editing item"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: textName,
              decoration: const InputDecoration(
                hintText: "Item name",
              ),
            ),
            TextField(
              controller: textQuantity,
              decoration: const InputDecoration(
                hintText: "Item quantity",
              ),
            ),
            TextField(
              controller: textNote,
              decoration: const InputDecoration(
                hintText: "Item note",
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  listItems.name = textName.text;
                  listItems.quantity = textQuantity.text;
                  listItems.note = textNote.text;
                  listItems.idList = shoppingList.id;
                  await dbHelper.insertItems(listItems);
                  Navigator.pop(context);
                },
                child: const Text("Save item"))
          ],
        ),
      ),
    );
  }
}
