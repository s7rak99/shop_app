// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class OnBoardTask extends StatelessWidget {
//   Future<String> getSakaryaAir() async {
//     String url =
//         'https://student.valuxapps.com/api/favorite' ;
//     final response =
//     await http.get(url as Uri, headers: {"Accept": "application/json"});
//
//     return response.body;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Stream.periodic(Duration(seconds: 6))
//           .asyncMap((i) => getSakaryaAir()), // i is null here (check periodic docs)
//       builder: (context, snapshot) {
//         return Scaffold(
//           appBar: AppBar(),
//           body: Text(snapshot.data.toString(),
//         ));
//
//       } );
//   }
// }