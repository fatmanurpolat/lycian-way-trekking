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
        title: Text(
          'Rotayı Seçin',
          textAlign: TextAlign.center,
          style: TextStyle(color: CustomColors.DARK_GREEN, fontSize: 25),
        ),
        backgroundColor: Colors.white,
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
                  height: 260,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ), // Her buton arası boşluk
                  child: Card(
                    elevation: 5, // Kartın gölge derinliği
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ), // Kartın köşelerini yuvarlar
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              RouteDetailsView(routeData: routeData),
                        ));
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/detail_photo.webp',
                            fit: BoxFit.cover,
                            width: double
                                .infinity, // Görüntüyü tüm genişliği kaplaması için
                            height: double
                                .infinity, // Görüntüyü tüm yüksekliği kaplaması için
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withOpacity(
                                0.3), // Üzerine yazılan metni okunaklı hale getirmek için bir arka plan ekler.
                            child: Center(
                              child: Text(
                                routeName,
                                style: TextStyle(
                                  fontFamily:
                                      'Times New Roman', // Yazı tipi: Times New Roman
                                  fontSize: 25.0, // Yazı boyutu
                                  fontWeight:
                                      FontWeight.normal, // Yazı kalınlığı
                                  color: Colors.white, // Yazı rengi
                                ),
                              ),
                            ),
                          ),
                        ],
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
