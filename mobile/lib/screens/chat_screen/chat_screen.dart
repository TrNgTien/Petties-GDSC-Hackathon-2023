import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/screens/chat_screen/widgets/bubble_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final dynamic userData;
  ChatScreen({super.key, required this.userData});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<BubbleChat> _messages = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      _focusNode.requestFocus();
    });
    socket = IO.io('http://localhost:8080');
    socket.on('message', (data) {
      BubbleChat message = BubbleChat(
        message: data,
        isMe: false,
        time: DateTime.now().toIso8601String(),
      );
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();

    BubbleChat message = BubbleChat(
      message: text,
      isMe: true,
      time: DateTime.now().toIso8601String(),
    );

    setState(() {
      _messages.insert(0, message);
    });
    // socket.emit("event", )
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(widget.userData["userAvatar"]),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${widget.userData["userName"]}",
            style: const TextStyle(color: Colors.black),
          ),
        ]),
        backgroundColor: primaryBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              reverse: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
            height: 50,
            color: grayColor50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: blueBackgroundPet,
                  onPressed: () {
                    _handleSubmitted(_textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
