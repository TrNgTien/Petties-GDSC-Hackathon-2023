import 'package:mobile/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widget/DraggableModal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => DraggableSheet(
                child: Container(
                  color: Colors.white,
                  height: 500.0,
                  child: const Center(
                    child: Text('Drag me down to close'),
                  ),
                ),
              ),
            );
          },
          child: Text('Show Draggable Sheet'),
        ),
      ),
    );
  }
}
