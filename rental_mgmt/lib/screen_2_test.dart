import 'package:flutter/material.dart';

class Circle {
  final String name;
  final String phoneNumber;
  final String address;
  final String email;

  Circle({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
  });
}

class SquareBox extends StatefulWidget {
  int numberOfCircles;
  final List<Circle> circles;

  SquareBox({required this.numberOfCircles, required this.circles});

  @override
  _SquareBoxState createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
  bool isAddingCircle = false;

  @override
  Widget build(BuildContext context) {
    int circlesPerRow = widget.numberOfCircles <= 10 ? widget.numberOfCircles : 10;
    int numberOfRows = (widget.numberOfCircles / circlesPerRow).ceil();

    double circleSize = 40.0;
    double containerWidth = circlesPerRow * (circleSize + 16.0);
    double containerHeight = numberOfRows * (circleSize + 16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Square Box'),
      ),
      body: Center(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          color: Colors.grey,
          child: GridView.count(
            crossAxisCount: circlesPerRow,
            children: List.generate(
              widget.numberOfCircles,
              (index) {
                if (index >= widget.circles.length) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue, width: 2.0),
                    ),
                  );
                }

                Circle circle = widget.circles[index];

                return Dismissible(
                  key: Key(circle.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      widget.circles.removeAt(index);
                      widget.numberOfCircles--;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deleted ${circle.name}')),
                    );
                  },
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Information'),
                            content: SingleChildScrollView(
                              child: Table(
                                defaultColumnWidth: FixedColumnWidth(120.0),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Name'),
                                      ),
                                      TableCell(
                                        child: Text(circle.name),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Phone Number'),
                                      ),
                                      TableCell(
                                        child: Text(circle.phoneNumber),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Address'),
                                      ),
                                      TableCell(
                                        child: Text(circle.address),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Email'),
                                      ),
                                      TableCell(
                                        child: Text(circle.email),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
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
                  margin: EdgeInsets.all(8.0),
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  ),
  floatingActionButton: GestureDetector(
    onHorizontalDragEnd: (details) {
      if (details.primaryVelocity! > 0) {
        _showNumberOfCirclesDialog();
      }
    },
    child: FloatingActionButton(
      onPressed: _showNumberOfCirclesDialog,
      child: Icon(Icons.add),
    ),
  ),
);
}


void _showNumberOfCirclesDialog() {
showDialog(
context: context,
builder: (BuildContext context) {
int newNumberOfCircles = 0;                              
    return AlertDialog(
      title: Text('Add Circles'),
      content: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          newNumberOfCircles = int.tryParse(value) ?? 0;
        },
        decoration: InputDecoration(
          labelText: 'Number of Circles',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              widget.numberOfCircles += newNumberOfCircles;
              for (int i = 0; i < newNumberOfCircles; i++) {
                widget.circles.add(Circle(
                  name: 'Circle ${widget.numberOfCircles + i}',
                  phoneNumber: '',
                  address: '',
                  email: '',
                ));
              }
            });
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  },
);
}
}

void main() {
runApp(MaterialApp(
home: SquareBox(numberOfCircles: 9, circles: [
Circle(
name: 'John Doe',
phoneNumber: '1234567890',
address: '123 Main St',
email: 'johndoe@example.com',
),
Circle(
name: 'Jane Smith',
phoneNumber: '0987654321',
address: '456 Broadway',
email: 'janesmith@example.com',
),
]),
));
}