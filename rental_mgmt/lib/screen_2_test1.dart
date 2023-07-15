import 'package:flutter/material.dart';

class Circle {
  final String name;
  final String phoneNumber;

  Circle({required this.name, required this.phoneNumber});
}

class SquareBox extends StatefulWidget {
  @override
  _SquareBoxState createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
  List<List<Circle>> circlesData = [
    [
      Circle(name: 'John Doe', phoneNumber: '1234567890'),
      Circle(name: 'Jane Smith', phoneNumber: '0987654321'),
    ],
    // Add more box data as needed
  ];

  int currentBoxIndex = 0;

  void _addNewBox() {
    setState(() {
      circlesData.add([]);
      currentBoxIndex = circlesData.length - 1;
    });
  }

  void _goToPreviousBox() {
    setState(() {
      if (currentBoxIndex > 0) {
        currentBoxIndex--;
      }
    });
  }

  void _goToNextBox() {
    setState(() {
      if (currentBoxIndex < circlesData.length - 1) {
        currentBoxIndex++;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Circle> circles = circlesData[currentBoxIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Square Box'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _goToPreviousBox,
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    '${currentBoxIndex + 1}/${circlesData.length}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: _goToNextBox,
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: circles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Information'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Name: ${circles[index].name}'),
                                SizedBox(height: 8.0),
                                Text('Phone Number: ${circles[index].phoneNumber}'),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBox,
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SquareBox(),
  ));
}
