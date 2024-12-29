import 'package:flutter/material.dart';
import 'package:market/components/my_button.dart';
import 'package:market/components/my_dropdown.dart';
import 'package:market/components/my_textfield.dart';
import 'package:market/database/firestore.dart';

class ContractAddPage extends StatefulWidget {
  ContractAddPage({super.key});

  @override
  State<ContractAddPage> createState() => _ContractAddPageState();
}

class _ContractAddPageState extends State<ContractAddPage> {
  // firestore database
  final FirestoreClient firestoreClient = FirestoreClient();
  final FirestoreHome firestoreHome = FirestoreHome();
  final FirestoreContract firestoreContract = FirestoreContract();

  // text controller
  final TextEditingController price = TextEditingController();

  final TextEditingController other = TextEditingController();

  String? selectedHome;

  String? selectedClient;

  // add
  void add() async {
    final Map<String, dynamic> contractData = {
      'Price': price.text,
      'Paid': '0',
      'HomeName': selectedHome,
      'ClientName': selectedClient,
      'Other': other.text
    };
    firestoreContract.addContract(contractData);

    // clear the controller
    price.clear();
    other.clear();
    selectedHome = '';
    selectedClient = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shartnoma rasmiylashtirish"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextfield(
                hintText: 'narxni kiriting',
                obscureText: false,
                controller: price),
          ),
          // Uy ro'yxati StreamBuilder orqali
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: firestoreHome.getHomeStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text("Xatolik yuz berdi!");
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text("Uylar mavjud emas.");
                }

                // Firestore'dan kelgan ma'lumotlarni variantlar ro'yxatiga aylantirish
                final clients = snapshot.data!.docs
                    .map((doc) => doc['HomeName'] as String)
                    .toList();

                return MyDropdown(
                  items: clients, // Dropdown uchun variantlar
                  hint: "Uyni tanlang",
                  value: selectedHome,
                  onChanged: (value) {
                    setState(() {
                      selectedHome = value;
                    });
                  },
                );
              },
            ),
          ),
          // Mijozlar ro'yxati StreamBuilder orqali
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: firestoreClient.getClientStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text("Xatolik yuz berdi!");
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text("Mijozlar mavjud emas.");
                }

                // Firestore'dan kelgan ma'lumotlarni variantlar ro'yxatiga aylantirish
                final clients = snapshot.data!.docs
                    .map((doc) => doc['FullName'] as String)
                    .toList();

                return MyDropdown(
                  items: clients, // Dropdown uchun variantlar
                  hint: "Mijozni tanlang",
                  value: selectedClient,
                  onChanged: (value) {
                    setState(() {
                      selectedClient = value;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: MyTextfield(
                    hintText: "Batafsil",
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
