import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class nodeSelector extends StatefulWidget {
  const nodeSelector({super.key});

  @override
  State<nodeSelector> createState() => _nodeSelectorState();
}

class _nodeSelectorState extends State<nodeSelector> {
  final List<String> _items = [
    'Node 1: Tomato',
    'Node 2: Eggplant',
    'Node 3: Pepper',
    'Node 4: Potato',
  ];

  String _selectedItem = 'Node 1: Tomato';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Center(
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: 'Select a Node',
            labelStyle: const TextStyle(
                fontFamily: "Rokkitt", fontSize: 24.0, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.white), // Set border color
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.white), // Set border color
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          value: _selectedItem,
          items: _items.map((String item) {
            return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Rokkitt",
                      fontSize: 18.0),
                ));
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedItem = value!;
            });
          },
          icon: const Icon(Icons.arrow_drop_down),
          iconEnabledColor: Colors.white,
        ),
      ),
    );
  }
}
