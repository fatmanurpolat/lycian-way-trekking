import 'package:flutter/material.dart';
import 'package:restart_project/core/services/firestore_service.dart';
import 'package:restart_project/core/utils/app_config.dart';

class RoutesView extends StatefulWidget {
  @override
  _RoutesViewState createState() => _RoutesViewState();
}

class _RoutesViewState extends State<RoutesView> {
  FirestoreService viewModel = FirestoreService();
  List<double> cardHeights = List.generate(
      100, (index) => 80.0); // Initialize the card heights with a default value
  String routeName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: viewModel.getAllRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Veriler alınırken hata oluştu: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Rota bulunamadı.');
          } else {
            // Verileri göstermek için ListView.builder kullanın
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var routeData =
                    snapshot.data![index].data() as Map<String, dynamic>;
                var routeName = routeData['name']; // Rota adı

                return GestureDetector(
                  onTap: () {
                    print("tıklandı");
                    setState(() {
                      // Update the height of the tapped card
                      cardHeights[index] =
                          cardHeights[index] == 80.0 ? 320.0 : 80.0;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300), // Animation duration
                    height: cardHeights[index], // Use the updated height
                    child: Card(
                      color: CustomColors.BLUE_GRADIANT_END,
                      child: ListTile(
                        title: Text(routeName),
                        // Diğer rota verilerini burada gösterin
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:restart_project/view/route/routes_selection_view.dart.dart';

// class RoutesView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rota Seç'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (_) => RouteSelectionView(),
//             ));
//           },
//           child: Text('Rota Seç'),
//         ),
//       ),
//     );
//   }
// }
