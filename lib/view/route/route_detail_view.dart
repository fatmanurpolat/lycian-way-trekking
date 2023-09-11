// import 'package:flutter/material.dart';

// class RouteDetailsView extends StatelessWidget {
//   final Map<String, dynamic> routeData;

//   RouteDetailsView({required this.routeData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(routeData['name']),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               child: ListTile(
//                 title: Text('Name: ${routeData['name']}'),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('Altitude: ${routeData['altitude']}'),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('Time: ${routeData['time']}'),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('Distance: ${routeData['distance']}'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
