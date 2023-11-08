import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shopping_list.dart';
import 'package:flutter_application_1/ui/items_screen.dart';
import 'package:flutter_application_1/ui/shopping_list_dialog.dart';
import 'package:flutter_application_1/utils/dbhelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return const MaterialApp(
      home: ShowList());
  }
}

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {

  ShoppingListDialog? shoppingListDialog;

  @override
  void initState(){
    shoppingListDialog = ShoppingListDialog();
    super.initState();
  }

  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList = [];

  @override
  Widget build(BuildContext context) {
    
    showData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping list"),
      ),
      body: ListView.builder(
        itemCount: (shoppingList != null)? shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(shoppingList[index].name),
            leading: CircleAvatar(
              child: Text(shoppingList[index].priority.toString()),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) => shoppingListDialog!.buildDialog(context, shoppingList[index], false));
                
              },
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ItemScreen(shoppingList[index])));
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => shoppingListDialog!.buildDialog(context, ShoppingList(0, '', 0), true)
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add new shopping list',
        )
    );
  }
  
  Future<void> showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();

    setState(() {
      shoppingList = shoppingList;
    });

  }
}