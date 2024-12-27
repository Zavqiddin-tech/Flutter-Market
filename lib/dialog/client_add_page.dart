import 'package:flutter/material.dart';
import 'package:market/components/my_button.dart';
import 'package:market/components/my_textfield.dart';
import 'package:market/database/firestore.dart';

class ClientAddPage extends StatelessWidget {
  ClientAddPage({super.key});

  // firestore database
  final FirestoreClient database = FirestoreClient();

  // text controller
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneOne = TextEditingController();
  final TextEditingController phoneTwo = TextEditingController();
  final TextEditingController other = TextEditingController();

  // add
  void add() async {
    final Map<String, dynamic> clientData = {
      'FullName': fullName.text,
      'PhoneOne': phoneOne.text,
      'PhoneTwo': phoneTwo.text,
      'Other': other.text,
    };
    database.addClient(clientData);

    // clear the controller
    fullName.clear();
    phoneOne.clear();
    phoneTwo.clear();
    other.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ro'yxatga olish"),
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
                    hintText: 'Ism familya',
                    obscureText: false,
                    controller: fullName)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: MyTextfield(
                    hintText: 'Telefon raqam 1',
                    obscureText: false,
                    controller: phoneOne)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: MyTextfield(
                    hintText: 'Telefon raqam 2',
                    obscureText: false,
                    controller: phoneTwo)),
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
