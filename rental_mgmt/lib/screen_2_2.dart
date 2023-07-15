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
  @override
  _SquareBoxState createState() => _SquareBoxState();
}

class _SquareBoxState extends State<SquareBox> {
  List<Square> squareList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Square Box'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: squareList.length,
              itemBuilder: (context, index) {
//                return squareList[index];
                 return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_) {
                    setState(() {
                      squareList.removeAt(index);
                    });
                  },
                  child: Square(
                    numberOfRooms: squareList[index].numberOfRooms,
                    buildingName: squareList[index].buildingName,
                    onDelete: () {
                      setState(() {
                        squareList.removeAt(index);
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _showSquareDialog();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showSquareDialog() {
    int numberOfRooms = 0;
    String buildingName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Building'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  buildingName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Building Name',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  numberOfRooms = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(
                  labelText: 'Number of Rooms',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Square newSquare = Square(
                    numberOfRooms: numberOfRooms,
                    buildingName: buildingName,
                  );
                  squareList.add(newSquare);
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


class Square extends StatelessWidget {
  final int numberOfRooms;
  final String buildingName;
  final VoidCallback? onDelete;

  Square({
    required this.numberOfRooms,
    required this.buildingName,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                buildingName,
                textAlign: TextAlign.center, // Center the building name in the row
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                }
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
               showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Delete'),
                    content: Text('Are you sure you want to delete Building: $buildingName box?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: onDelete,
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
            ),
            itemCount: numberOfRooms,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Circle circle = Circle(
                        name: 'Circle $index',
                        phoneNumber: '1234567890',
                        address: '123 Main St',
                        email: 'circle$index@example.com',
                        rentTransactions: [
                          RentTransaction(
                            rentDate: DateTime(2023, 6, 15),
                            rentAmount: 1000.0,
                          ),
                          RentTransaction(
                            rentDate: DateTime.now(),
                            rentAmount: 1500.0,
                          ),
                        ],
                      );
                      return Dialog(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Room ${index + 1}',
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
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SquareBox(),
  ));
}
