import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text('Rental Management'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250.0,
                    height: 40.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: 250.0,
                    height: 40.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Set button color to green
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Make button text bold
                      ),
                      minimumSize: Size(120.0, 40.0), // Set button size
                    ),
                    onPressed: () {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      // Perform login/authentication logic here
                      // You can validate the input and handle authentication
                      // based on your requirements
                      print('Username: $username');
                      print('Password: $password');
                    },
                      icon: Icon(Icons.lock),
                      label: Text(
                        'LOGIN'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),                  
                      ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Perform "Don't have an account?" logic here
                      print('Don\'t have an account button pressed');
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white, // Set text color to white
                    ),
                    child: Text('Don\'t have an account?'),
                  ),                 
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Set button color to green
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Make button text bold
                      ),
                      minimumSize: Size(120.0, 40.0), // Set button size
                    ),
                    onPressed: () {
                      // Perform signup logic here
                      print('Signup button pressed');
                    },
                    child: Text('SIGN UP'.toUpperCase()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginForm(),
  ));
}