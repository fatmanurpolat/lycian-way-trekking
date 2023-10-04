import 'package:flutter/material.dart';
import 'package:restart_project/view/dashboard/dashboard_selection_route.dart';

class DashboardMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WELCOME ADVANTURES!",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.hiking_rounded,
              color: Color.fromARGB(255, 41, 112, 9),
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/detail_photo.webp"),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //       Colors.black.withOpacity(0.5), // Yarı opaklık için renk ayarı
        //       BlendMode.dstATop,
        //     ),
        //   ),
        // ),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
                image: DecorationImage(
                  image: AssetImage("assets/images/detail_photo.webp"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black
                        .withOpacity(0.5), // Yarı opaklık için renk ayarı
                    BlendMode.dstATop,
                  ),
                ),
              ),
              height: 201,
              child: const Padding(
                padding: EdgeInsets.all(45.0),
                child: Text(
                  "Macera Dolu Likya Yolu Yürüyüşünüzde Bol Eğlence, Huzur ve Güzellik Diliyoruz!",
                  style: TextStyle(
                      fontSize: 23,
                      wordSpacing: 4,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage("assets/images/victory.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 10,
                    child: Container(
                      child: Center(
                          child: Text(
                        "Burada hava durumu gösterilecek",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage("assets/images/wheater.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DashboardSelectionView(),
                ));
              },
              child: Text('Rota Seç'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 40, 112, 44)!, // Orman yeşili renk
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
