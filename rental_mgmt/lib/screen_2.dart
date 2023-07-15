import 'package:flutter/material.dart';

class RentTransaction {
  final DateTime rentDate;
  final double rentAmount;

  RentTransaction({
    required this.rentDate,
    required this.rentAmount,
  });
}

class Circle {
  final String name;
  final String phoneNumber;
  final String address;
  final String email;
  final List<RentTransaction> rentTransactions;

  Circle({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.rentTransactions,
  });
}

class SquareBox extends StatefulWidget {
  final int numberOfCircles;

  SquareBox({required this.numberOfCircles});

  @override
  State<SquareBox> createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
  List<Circle> squareList = [
    Circle(
      name: 'John Doe',
      phoneNumber: '1234567890',
      address: '123 Main St',
      email: 'johndoe@example.com',
      rentTransactions: [
        RentTransaction(rentDate: DateTime(2023, 6, 15), rentAmount: 1000.0),
        RentTransaction(rentDate: DateTime(2023, 7, 1), rentAmount: 1500.0),
        RentTransaction(rentDate: DateTime(2023, 7, 15), rentAmount: 1200.0),
      ],
    ),
    Circle(
      name: 'Jane Smith',
      phoneNumber: '0987654321',
      address: '456 Broadway',
      email: 'janesmith@example.com',
      rentTransactions: [
        RentTransaction(rentDate: DateTime(2023, 6, 20), rentAmount: 1200.0),
        RentTransaction(rentDate: DateTime(2023, 7, 5), rentAmount: 1400.0),
      ],
    ),
    // Add more circle data as needed
  ];

  int currentIndex = 0;

  void goToPreviousBox() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void goToNextBox() {
    setState(() {
      if (currentIndex < squareList.length - 1) {
        currentIndex++;
      }
    });
  }


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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Hi'),
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
          ),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
              width: containerWidth,
              height: containerHeight,
              color: Colors.grey,   
              child: GridView.count(
                crossAxisCount: circlesPerRow,
                children: List.generate(
                  widget.numberOfCircles,
                  (index) {
                    if (index >= squareList.length) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: Colors.blue, width: 2.0),
                        ),
                      );
                    }

                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Circle circle = squareList[index];
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                height: MediaQuery.of(context).size.height * 0.6, // Set the desired height
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        index == 0 ? 'Room 1' : 'Room ${index + 1}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text('Contact'),
                                      SizedBox(height: 8.0),
                                      DataTable(
                                        columns: [
                                          DataColumn(label: Text('Attribute')),
                                          DataColumn(label: Text('Value')),
                                        ],
                                        rows: [
                                          DataRow(
                                            cells: [
                                              DataCell(Text('Name')),
                                              DataCell(Text(circle.name)),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('Phone Number')),
                                              DataCell(Text(circle.phoneNumber)),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('Address')),
                                              DataCell(Text(circle.address)),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(Text('Email')),
                                              DataCell(Text(circle.email)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16.0),
                                      Text('Rent'),
                                      SizedBox(height: 8.0),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columns: [
                                            DataColumn(label: Text('Date')),
                                            DataColumn(label: Text('Amount')),
                                          ],
                                          rows: circle.rentTransactions.map((transaction) {
                                            return DataRow(
                                              cells: [
                                                DataCell(Text(transaction.rentDate.toString())),
                                                DataCell(Text('\$${transaction.rentAmount.toStringAsFixed(2)}')),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                      child: Stack(
                         alignment: Alignment.center,
                        children: [
                           Text(
                            (index + 1).toString(), // Display the circle number
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                             ),
                           ),
                          ],
                        ), 
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: goToPreviousBox,
                  ),
                  Text(
                    '${currentIndex + 1}/${squareList.length}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: goToNextBox,
                  ),
                ],
              ),
            ),
              ],)
            ),
          SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Hi'),
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
            icon: Icon(Icons.add),
            label: Text('Add'),
          ), 
/*          
          FloatingActionButton(
          onPressed: _showNumberOfCirclesDialog,
          child: Icon(Icons.add),
             ),
*/
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SquareBox(numberOfCircles: 36),
  ));
}
