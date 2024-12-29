import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items; // Dropdownda ko'rsatiladigan elementlar
  final String hint; // Dropdown uchun prompt matni
  final void Function(String?) onChanged; // Dropdown qiymati o'zgarganida chaqiriladigan callback
  final String? value; // Tanlangan qiymat

  const MyDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.value,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.value,
      hint: Text(widget.hint),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down_circle),
      onChanged: widget.onChanged,
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
    );
  }
}
