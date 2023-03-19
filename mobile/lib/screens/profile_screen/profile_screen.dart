import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _phone = '+1 (555) 123-4567';
  String _address = '123 Main St, Anytown USA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        elevation: 0,
        backgroundColor: backgroundAppBar,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(
          color: appbarColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(_name),
            SizedBox(height: 16.0),
            Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(_email),
            SizedBox(height: 16.0),
            Text(
              'Phone',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(_phone),
            SizedBox(height: 16.0),
            Text(
              'Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(_address),
          ],
        ),
      ),
    );
  }
}
