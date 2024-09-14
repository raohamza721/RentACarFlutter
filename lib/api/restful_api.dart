import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RestfulApi extends StatefulWidget{
  const RestfulApi({super.key});


  @override
  State<RestfulApi> createState() => _RestfulApiState();
}

class _RestfulApiState extends State<RestfulApi> {
  List<dynamic> photos= [];

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

          itemCount: photos.length,
          itemBuilder: (context, index){
            final user = photos[index];
            final id = user['id'];
            final title = user['title'];
            final thumbnailUrl = user['url'];
            return ListTile(
              leading: Image.network(thumbnailUrl) ,
              title: Text(title.toString()),
              subtitle: Text(id.toString()),
            );

          }
      ),

    );
  }

  Future<void> fetchUsers() async {

    print("Data Fetched");



    const url = "https://jsonplaceholder.typicode.com/photos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {

      photos = json ;
    });
    print("Data Fetched");
  }
}
