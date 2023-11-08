import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_items.dart';
import 'package:flutter_application_1/models/shopping_list.dart';
import 'package:flutter_application_1/ui/shopping_list_dialog.dart';
import 'package:flutter_application_1/utils/dbhelper.dart';

class ItemScreen extends StatefulWidget {

  final ShoppingList shoppingList;
  ItemScreen(this.shoppingList);

  @override
  State<ItemScreen> createState() => _ItemScreenState(this.shoppingList);
}

class _ItemScreenState extends State<ItemScreen> {

  final ShoppingList shoppingList;
  _ItemScreenState(this.shoppingList);

  DbHelper? dbHelper;
  List<ListItems> items = [];

  @override
  Widget build(BuildContext context) {

    dbHelper = DbHelper();
    showData(shoppingList.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
        itemCount: (items != null)? items.length : 0,
        itemBuilder: (BuildContext context,  int index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text("Quantity: ${items[index].quantity} - Note: ${items[index].note}"),
            trailing: IconButton(
              icon: Icon(Icons.edit), 
              onPressed: () 
              {  
                
              },),
          );
        },
      ),
    );
  }

  Future showData(int idList) async {
    await dbHelper!.openDb();
    items = await dbHelper!.getItems(idList);
    setState(() {
      items = items;
    });
  }

}