import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<String> pizza = <String>["Маргарита", "М'ясна", "Чотири сири"];

final List<String> receptPizza = <String>[
  "Кукурудза, томати, сир, курка, ананас",
  "Бекон, мисливські ковбаски, сир",
  "Чедер, Мацарела, Фетта, Рокфорд",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pizza App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Список піц",
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(227, 66, 31, 91),
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
        ),
        body: PizzaListView(),
      ),
    );
  }
}

class PizzaListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: pizza.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.local_pizza, size: 28, color: Colors.red),
          title: Text(
            pizza[index],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: "Nunito",
            ),
          ),
          subtitle: Text("Склад: ${receptPizza[index]}"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            print("Вибрано піцу: ${pizza[index]}");

            Fluttertoast.showToast(
              msg: "Вибрано піцу: ${pizza[index]}",
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },
        );
      },
    );
  }
}
