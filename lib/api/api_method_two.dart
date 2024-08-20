import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentacar/api/model_api_method_two.dart';



class RestfulApiMethodTwo extends StatefulWidget{
  const RestfulApiMethodTwo({super.key});


  @override
  State<RestfulApiMethodTwo> createState() => _RestfulApiMethodTwoState();
}

class _RestfulApiMethodTwoState extends State<RestfulApiMethodTwo> {
  List<MethodTwo> users= [];

  @override
  void initState() {
    super.initState();
    fetchUsersTwo;
  }

  @override
  Widget build(BuildContext context){

    return  Scaffold(
      appBar: AppBar(title: const Text('Api practice method 2')
      ),
      floatingActionButton: FloatingActionButton(onPressed:  fetchUsersTwo,
        child:  const Icon(Icons.add),
      ),

      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index){
            final user = users[index];
            final name = user.name;
            final email = user.email;
            final gender = user.gender;
            final image = user.picture;


            return ListTile(
              leading: Image.network(image),
              title: Text(name),
              subtitle: Text(email),

            );
          }
      ),
    );
  }

  Future<void> fetchUsersTwo() async {

    print("Data Fetched");

    const url = "https://randomuser.me/api/?results=50";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    final results = json['results'] as List<dynamic>;

    final transformed = results.map((e)  => MethodTwo.fromJson(e)).toList();
    // {
    //   return MethodTwo(gender: e["gender"], name: e["name"], email: e['email'], phone: e['phone']);
    // }).toList();

    setState(() {
      users = transformed;
    });

    print("Data Fetched");
  }
}
