import 'package:flutter/material.dart';
import 'package:market/components/my_button.dart';
import 'package:market/components/my_textfield.dart';
import 'package:market/database/firestore.dart';

class HomeAddPage extends StatelessWidget {
  HomeAddPage({super.key});

  // firestore database
  final FirestoreHome database = FirestoreHome();

  // text controller
  final TextEditingController homeName = TextEditingController();
  final TextEditingController homeCount = TextEditingController();
  final TextEditingController other = TextEditingController();

  // add
  void add() async {
    final Map<String, dynamic> homeData = {
      'HomeName': homeName.text,
      'HomeCount': homeCount.text,
      'Other': other.text,
      'Busy': false,
    };
    database.addHome(homeData);

    // clear the controller
    homeName.clear();
    homeCount.clear();
    other.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uyni qo'shish"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: MyTextfield(
                    hintText: 'Uy nomi',
                    obscureText: false,
                    controller: homeName)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: MyTextfield(
                    hintText: 'Xonalar soni',
                    obscureText: false,
                    controller: homeCount)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: MyTextfield(
                    hintText: "Qo'shimcha",
                    obscureText: false,
                    controller: other)),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MyButton(text: 'Saqlash', onTap: add),
          )
        ],
      ),
    );
  }
}
