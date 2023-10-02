import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({super.key});
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Shopping Page')),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final email = user['email'];
                    final name = user['name']['first'];
                    final image = user['picture']['thumbnail'];
                    return ListTile(
                      leading: CircleAvatar(child: Image.network(image)),
                      title: Text(name),
                      subtitle: Text(email),
                    );
                  })),
          FloatingActionButton(
            onPressed: () {
              fetchUsers();
            },
            child: Icon(Icons.add),
          )
        ]),
      ),
    );
  }

  void fetchUsers() async {
    // print('Fetching started');
    const url = 'https://randomuser.me/api/?results=50';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });

    // print('Fetching completed');
  }
}
