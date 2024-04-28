import 'package:flutter/material.dart';

class nodeSelector extends StatefulWidget {
  const nodeSelector({super.key});

  @override
  State<nodeSelector> createState() => _nodeSelectorState();
}

class _nodeSelectorState extends State<nodeSelector> {
  String? _selectedItem;

  final List<String> _items = [
    'Node 1: Tomato',
    'Node 2: Eggplant',
    'Node 3: Pepper',
    'Node 4: Potato',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: DropdownButton<String>(
          icon: const Icon(Icons.arrow_drop_down), // Arrow icon on the right
          iconSize: 20.0,
          isExpanded: true, // Set width to maximum
          hint: const Padding(
            padding: EdgeInsets.all(8.0), // Adding padding to the hint
            child: Text('Select a Node',
                style: TextStyle(fontSize: 14.0)), // Reduced font size
          ),
          value: _selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue;
            });
          },
          items: _items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding:
                    const EdgeInsets.all(8.0), // Adding padding to the text
                child: Text(value,
                    style:
                        const TextStyle(fontSize: 14.0)), // Reduced font size
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
