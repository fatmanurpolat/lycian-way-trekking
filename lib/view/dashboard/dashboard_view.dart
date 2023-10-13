import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/dashboard/dashboard_selection_route.dart';

class DashboardMainView extends StatelessWidget {
  const DashboardMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WELCOME ADVANTURES!",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(255, 41, 112, 9),
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/hiking_view.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.green.withOpacity(0.5), // Yarı opaklık için renk ayarı
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
                  fontSize: 20,
                  wordSpacing: 4,
                  fontFamily: 'YoungSerif',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 80,
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
                      image: const DecorationImage(
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
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/degre.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Burada hava durumu gösterilecek",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DashboardSelectionView(),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.DARK_GREEN,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Rota Seç')),
        ],
      )),
    );
  }
}
