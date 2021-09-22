import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gallery/bottom_app_bar_demo.dart';

import 'app_bar_demo.dart';
import 'banner_demo.dart';
import 'bottom_navigation_demo.dart';
import 'bottom_sheet_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => DemoPage(),
        '/app_bar': (_) => AppBarDemo(),
        '/banner': (_) => BannerDemo(),
        '/bottom_app_bar': (_) => BottomAppBarDemo(),
        '/bottom_navigation': (_) => BottomNavigationDemo(),
        '/bottom_sheet': (_) => BottomSheetDemo(),
      },
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _renderHeader("Material"),
          _renderDemoItem(context, "App bar Demo", "/app_bar"),
          _renderDemoItem(context, "Banner Demo", "/banner"),
          _renderDemoItem(context, "Bottom App bar Demo", "/bottom_app_bar"),
          _renderDemoItem(
              context, "Bottom Navigation Demo", "/bottom_navigation"),
          _renderDemoItem(context, "Bottom Sheet Demo", "/bottom_sheet"),
        ],
      ),
    );
  }

  Container _renderHeader(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade500))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _renderDemoItem(
      BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade500))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
