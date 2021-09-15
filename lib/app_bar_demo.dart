import 'package:flutter/material.dart';

class AppBarDemo extends StatelessWidget {
  const AppBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text("App bar Demo"),
        actions: [
          IconButton(
            tooltip: "즐겨찾기",
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "검색",
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text("첫 번째")),
                PopupMenuItem(child: Text("두 번째")),
                PopupMenuItem(child: Text("세 번째")),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Text("홈"),
      ),
    );
  }
}
