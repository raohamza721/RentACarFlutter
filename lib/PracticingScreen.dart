
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget{
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {

  final TextEditingController myNameController = TextEditingController();
  final TextEditingController myFatherController = TextEditingController();

  String? fetchName = "";
  String? fetchFatherName = "";

 // File? _SelectedImage;

  @override
  void initState(){

    super.initState();
    fetchDataFromFirebase();
  }
  //change the picked image into path

  // Future<void> _pickedImage() async{
  //
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if(pickedFile != null){
  //
  //     setState(() {
  //       _SelectedImage = File(pickedFile.path);
  //
  //     });
  //   }else{
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('No image selected')),);
  //   }
  //
  // }
  //
  // Future<void> _uploadImage() async{
  //
  //
  //
  // }

  Future<void> fetchDataFromFirebase() async{

    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("UserDataPractice").where("Name", isEqualTo: "Hamza").get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot document = snapshot.docs.first;
        setState(() {
          fetchName = document['Name'] ?? 'No Name';
          fetchFatherName = document['FatherName'] ?? 'No Father Name';
        });
      } else {
        setState(() {
          fetchName = 'No data found';
          fetchFatherName = 'No data found';
        });
      }
    } catch (e) {
      setState(() {
        fetchName = 'Error fetching data';
        fetchFatherName = 'Error fetching data';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }


  Future<void> StoreDataFirebase() async {


    String name = myNameController.text.trim();
    String fatherName = myFatherController.text.trim();

   if(name.isNotEmpty && fatherName.isNotEmpty ){

     try{
       await FirebaseFirestore.instance.collection("UserDataPractice").add({

         //"UserId" : UserId,
         "Name" : name,
         "FatherName" : fatherName,
       });
       ScaffoldMessenger.of(context).showSnackBar(

         const SnackBar(content: Text('Data stored successfully!')),

       );}catch(e){

       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data could not stored")));
     }
   }else{
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill All the fields")));

   }
  }
    @override
  void dispose(){
    myNameController.dispose();
    myFatherController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context )
  {
    return  Scaffold(
      body:
      Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile.png"),

            ),
            Card(
              elevation: 10, // Adding elevation to make the Card look raised
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(20.0), // Padding inside the Card
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Text('Name : $fetchName', style: const TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.w100,
                   ),),

                    const SizedBox(height: 20,),

                    Text("Father Name : $fetchFatherName ",style: const TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w100,
                    ),)
                  ],
                ),
              ),
            ),

            Card(
              elevation: 10, // Adding elevation to make the Card look raised
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Padding inside the Card
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: myNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        labelText: "Name",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: myFatherController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        labelText: "Father Name",
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await StoreDataFirebase();
              },
              style: ElevatedButton.styleFrom(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}



