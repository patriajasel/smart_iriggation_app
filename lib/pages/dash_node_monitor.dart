import 'package:flutter/material.dart';

class nodesListView extends StatelessWidget {
  const nodesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          elevation: 10,
          color: Colors.blue,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Node Monitoring',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: "Rokkitt",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 400, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 4, // Add elevation for a shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Rounded corners for the card
                          side: const BorderSide(
                              color: Colors.cyan,
                              width: 2), // Border color and width
                        ),
                        child: ListTile(
                          title: const Text(
                            "Plant: Tomato",
                            style: TextStyle(
                              fontFamily: "Rokkitt",
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            "Node Number: 1",
                            style: TextStyle(
                              fontFamily: "Rokkitt",
                              fontSize: 14.0,
                            ),
                          ),
                          onTap: () {
                            // Handle item tap
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
