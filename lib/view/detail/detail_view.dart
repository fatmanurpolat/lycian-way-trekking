import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  final String pageTitle;

  DetailsView(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Bu sayfa $pageTitle verilerini gösterir.'),
      ),
    );
  }
}
