import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

class nodeSelector extends StatefulWidget {
  const nodeSelector({super.key});

  @override
  State<nodeSelector> createState() => _nodeSelectorState();
}

class _nodeSelectorState extends State<nodeSelector> {
  List<String> arrangedList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readNodes();
  }

  void readNodes() {
    context.read<Database>().getNodes();
  }

  void arrangeNodeList(List<Nodes> _nList) {
    for (int i = 0; i < _nList.length; i++) {
      String item = "Node #${_nList[i].nodeNumber} : ${_nList[i].plant}";
      if (!arrangedList.contains(item)) {
        arrangedList.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nodesDatabase = context.watch<Database>();
    final List<Nodes> _nodes = nodesDatabase.currentNodes;

    arrangeNodeList(_nodes);

    String? _selectedItem;

    if (arrangedList.isNotEmpty) {
      _selectedItem = arrangedList[0];
    }

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
          items: arrangedList.map((String item) {
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
              _selectedItem = value;
            });
          },
          icon: const Icon(Icons.arrow_drop_down),
          iconEnabledColor: Colors.white,
        ),
      ),
    );
  }
}
