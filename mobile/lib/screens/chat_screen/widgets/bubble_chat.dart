import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class BubbleChat extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;

  BubbleChat({required this.message, required this.time, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.grey[300] : Colors.blue[100];
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
