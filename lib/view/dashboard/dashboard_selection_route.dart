import 'package:flutter/material.dart';
import 'package:restart_project/core/services/firestore_service.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/dashboard/dashboard_view_detail_route.dart';

class DashboardSelectionView extends StatelessWidget {
  final FirestoreService viewModel = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12, // Arka plan rengi
      appBar: AppBar(
        title: Text('Rotayı Seçin'),
        backgroundColor: CustomColors.DARK_GREEN,
      ),
      body: FutureBuilder(
        future: viewModel.getAllRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Veriler alınırken hata oluştu: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Rota bulunamadı.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var routeData =
                    snapshot.data![index].data() as Map<String, dynamic>;
                var routeName = routeData['name']; // Rota adı

                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0), // Her buton arası boşluk
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          91, 19, 148, 1), // Buton rengi (örnek olarak yeşil)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Butonun köşelerini yuvarlar
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => RouteDetailsView(routeData: routeData),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        routeName,
                        style: TextStyle(
                          fontFamily:
                              'Times New Roman', // Yazı tipi: Times New Roman
                          fontSize: 19.0, // Yazı boyutu
                          fontWeight: FontWeight.normal, // Yazı kalınlığı
                          color: Colors.white, // Yazı rengi
                        ),
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
