

class MethodTwo{

  final String gender;
  final String name ;
  final String email ;
  final String phone ;
  final String picture ;


  MethodTwo({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.picture,

  });

  factory MethodTwo.fromJson(Map<String, dynamic> json) {
    return MethodTwo(

      gender: json['gender'],
      name: json['name']['first'],
      email: json['email'],
      phone: json['phone'],
      picture: json['picture']["thumbnail"],



    );
  }
  }
