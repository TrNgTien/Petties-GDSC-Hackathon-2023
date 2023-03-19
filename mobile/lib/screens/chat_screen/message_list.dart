import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/screens/chat_screen/chat_screen.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final List<Map<String, String>> messageList = [
    {
      "userName": "Tien",
      "avatar": 'https://via.placeholder.com/150x150.png?text=User'
    },
    {
      "avatar": 'https://via.placeholder.com/150x150.png?text=User',
      "userName": "Tien1",
    },
    {
      "avatar": 'https://via.placeholder.com/150x150.png?text=User',
      "userName": "Tien2",
    },
    {
      "avatar": 'https://via.placeholder.com/150x150.png?text=User',
      "userName": "Tienyet?"
    },
    {
      "avatar": 'https://via.placeholder.com/150x150.png?text=User',
      "userName": "Tien212."
    },
    {
      "avatar": 'https://via.placeholder.com/150x150.png?text=User',
      "userName": "Tien121"
    },
  ];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  // List<String> _filteredMessageList() {
  //   final query = _searchController.text.toLowerCase();
  //   return messageList
  //       .where((message) => message.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Messages",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.create),
              color: Colors.black,
              onPressed: () {
                // Do something when the button is pressed
              },
            ),
          ],
          backgroundColor: primaryBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (text) => _onSearchChanged(),
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  userData: messageList[index],
                                )),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(messageList[index]["avatar"]!),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              messageList[index]['userName']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '10:30 AM',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.grey,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Last message from John Doe...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
