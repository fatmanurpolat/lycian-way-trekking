// import 'package:flutter/material.dart';
// import 'package:restart_project/core/services/firestore_service.dart';
// import 'package:restart_project/view/detail/detail_view.dart';
// import 'package:restart_project/view/route/route_detail_view.dart';

// class RouteSelectionView extends StatelessWidget {
//   final FirestoreService viewModel = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rotayı Seçin'),
//       ),
//       body: FutureBuilder(
//         future: viewModel.getAllRoutes(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Veriler alınırken hata oluştu: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('Rota bulunamadı.');
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 var routeData =
//                     snapshot.data![index].data() as Map<String, dynamic>;
//                 var routeName = routeData['name']; // Rota adı

//                 return ListTile(
//                   title: Text(routeName),
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) => RouteDetailsView(routeData: routeData),
//                     ));
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
