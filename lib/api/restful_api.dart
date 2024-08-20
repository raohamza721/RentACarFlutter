import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RestfulApi extends StatefulWidget{
  const RestfulApi({super.key});


  @override
  State<RestfulApi> createState() => _RestfulApiState();
}

class _RestfulApiState extends State<RestfulApi> {
  List<dynamic> users= [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: AppBar(title: const Text('Api practice')
      ),


      floatingActionButton: FloatingActionButton(onPressed:  fetchUsers,
        child:  const Icon(Icons.add),
      ),

      body: ListView.builder(

          itemCount: users.length,
          itemBuilder: (context, index){
            final user = users[index];
            final email = user['email'];
            final name = user['name']['first'];
            final image = user['picture']['thumbnail'];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(image
                ),
              ) ,
              title: Text(name),
              subtitle: Text(email),
            );

          }
      ),

    );
  }

  Future<void> fetchUsers() async {

    print("Data Fetched");

    const url = "https://randomuser.me/api/?results=50";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json ['results'];
    });
    print("Data Fetched");
  }
}
