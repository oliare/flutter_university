import 'package:flutter/material.dart';

class Pizza {
  final String title; 
  final String description; 
  final String fullDescription;
  final String url_img;

  const Pizza(this.title, this.description, this.fullDescription, this.url_img);
}

class PizzaDetail extends StatelessWidget {
  final Pizza pizzaSelected;
  const PizzaDetail({super.key, required this.pizzaSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pizzaSelected.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              pizzaSelected.title,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, fontFamily: "Nunito"),
            ),
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/${pizzaSelected.url_img}",
              width: 150,
            ),
            const SizedBox(height: 10),
            Text(
              pizzaSelected.fullDescription,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontFamily: "Nunito"),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, pizzaSelected.title);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

final List<Pizza> listReceptionPizza = [
  Pizza(
    "Маргарита",
    "Кукурудза, томати, сир, курка, ананас",
    "Інгредієнти:\n"
    "Основа піци: Борошно — 500 г, Дріжджі свіжі — 15 г, Олія — 50 мл, Вода — 320 мл, Сіль за смаком\n\n"
    "Начинка:\n"
    "Помідори — 6 шт., Часник — 2 зубчики, Олія — 50 мл, Твердий сир — 250 г, Зелень, Сіль, перець\n\n"
    "Приготування:\n"
    "1. Замісити тісто, додати олію та воду, вимішувати до пружності.\n"
    "2. Накрити серветкою і залишити підходити 1 годину.\n"
    "3. Розкачати тісто, викласти на присипаний борошном деко.\n"
    "4. Помідори обдати окропом, зняти шкірку, збити з олією та часником.\n"
    "5. Намазати соусом тісто, посипати половиною сиру.\n"
    "6. Викласти помідори кружечками, додати залишок сиру.\n"
    "7. Випікати при 220°C 15-20 хвилин до золотистої скоринки.",
    "pizza1.png",
  ),
  Pizza(
    "М'ясна",
    "Кукурудза, томати, сир, курка, ананас",
    "Інгредієнти:\n"
    "Основа піци: Борошно — 500 г, Дріжджі свіжі — 15 г, Вода — 320 мл, Олія — 50 мл, Сіль за смаком\n\n"
    "Начинка:\n"
    "Куряче філе — 200 г, Шинка — 100 г, Ковбаса салямі — 50 г, Помідори — 2 шт., Кукурудза — 50 г, Сир твердий — 150 г, Соус томатний — 50 мл, Сіль, перець, зелень\n\n"
    "Приготування:\n"
    "1. Приготуйте тісто як для піци Маргарита.\n"
    "2. Розкачати тісто, викласти на деко.\n"
    "3. Змастити соусом томатним, посипати сиром.\n"
    "4. Викласти нарізану курку, шинку, ковбасу, помідори та кукурудзу.\n"
    "5. Посипати залишком сиру та запікати при 220°C 15-20 хвилин.\n"
    "6. Подавати гарячою, прикрасивши зеленню.",
    "pizza2.png",
  ),
  Pizza(
    "Чотири сири",
    "Кукурудза, томати, сир, курка, ананас",
    "Інгредієнти:\n"
    "Основа піци: Борошно — 500 г, Дріжджі свіжі — 15 г, Вода — 320 мл, Олія — 50 мл, Сіль\n\n"
    "Начинка:\n"
    "Сир моцарела — 100 г, Сир пармезан — 50 г, Сир чеддер — 50 г, Сир горгонзола — 50 г, Соус вершковий — 50 мл\n\n"
    "Приготування:\n"
    "1. Приготуйте тісто, дайте підійти 1 годину.\n"
    "2. Розкачати тісто та викласти на деко.\n"
    "3. Змастити вершковим соусом.\n"
    "4. Посипати всі чотири види сирів рівномірно.\n"
    "5. Випікати при 220°C 12-15 хвилин до золотистої скоринки.\n"
    "6. Подавати гарячою, можна додати трохи зелені для прикраси.",
    "pizza3.png",
  ),
];


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pizza App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("List Pizza")),
        body: ListDinamicPizza(listPizza: listReceptionPizza),
      ),
    );
  }
}

class ListDinamicPizza extends StatelessWidget {
  final List<Pizza> listPizza;
  const ListDinamicPizza({super.key, required this.listPizza});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listPizza.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(listPizza[index].title, style: const TextStyle(fontSize: 22)),
          leading: Image.asset(
            "assets/images/${listPizza[index].url_img}",
            width: 50,
          ),
          trailing: const Icon(Icons.arrow_right),
          subtitle: Text("Склад: ${listPizza[index].description}"),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PizzaDetail(pizzaSelected: listPizza[index]),
              ),
            );
            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Вибрано піцу: $result'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        );
      },
    );
  }
}
