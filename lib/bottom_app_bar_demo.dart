import 'package:flutter/material.dart';

class BottomAppBarDemo extends StatefulWidget {
  const BottomAppBarDemo({Key? key}) : super(key: key);

  @override
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo>
    with RestorationMixin {
  final RestorableBool _showFab = RestorableBool(true);
  final RestorableBool _showNotch = RestorableBool(true);
  final RestorableInt _currentFabLocation = RestorableInt(0);

  @override
  String? get restorationId => 'bottom_app_bar_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_showFab, 'show_fab');
    registerForRestoration(_showNotch, 'show_notch');
    registerForRestoration(_currentFabLocation, 'fab_location');
  }

  @override
  void dispose() {
    _showFab.dispose();
    _showNotch.dispose();
    _currentFabLocation.dispose();
    super.dispose();
  }

  static const List<FloatingActionButtonLocation> _fabLocations = [
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.centerFloat,
  ];

  void _onShowNotchChanged(bool value) {
    setState(() {
      _showNotch.value = value;
    });
  }

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab.value = value;
    });
  }

  void _onFabLocationChanged(int value) {
    setState(() {
      _currentFabLocation.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('하단 앱 바'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: [
          SwitchListTile(
            value: _showFab.value,
            onChanged: _onShowFabChanged,
            title: Text('플로팅 액션 버튼'),
          ),
          SwitchListTile(
            value: _showNotch.value,
            onChanged: _onShowNotchChanged,
            title: Text('노치'),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('플로팅 액션 버튼 위치'),
          ),
          RadioListTile<int>(
            value: 0,
            groupValue: _currentFabLocation.value,
            onChanged: (value) => _onFabLocationChanged(value ?? 0),
            title: Text('도킹 - 끝'),
          ),
          RadioListTile<int>(
            value: 1,
            groupValue: _currentFabLocation.value,
            onChanged: (value) => _onFabLocationChanged(value ?? 0),
            title: Text('도킹 - 중앙'),
          ),
          RadioListTile<int>(
            value: 2,
            groupValue: _currentFabLocation.value,
            onChanged: (value) => _onFabLocationChanged(value ?? 0),
            title: Text('플로팅 - 끝'),
          ),
          RadioListTile<int>(
            value: 3,
            groupValue: _currentFabLocation.value,
            onChanged: (value) => _onFabLocationChanged(value ?? 0),
            title: Text('플로팅 - 중앙'),
          ),
        ],
      ),
      floatingActionButton: _showFab.value
          ? FloatingActionButton(
              onPressed: () {}, tooltip: '만들기', child: const Icon(Icons.add))
          : null,
      floatingActionButtonLocation: _fabLocations[_currentFabLocation.value],
      bottomNavigationBar: _DemoBottomAppBar(
          fabLocation: _fabLocations[_currentFabLocation.value],
          shape: _showNotch.value ? CircularNotchedRectangle() : null),
    );
  }
}

class _DemoBottomAppBar extends StatelessWidget {
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  const _DemoBottomAppBar({required this.fabLocation, required this.shape});

  static final centerLocations = [
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.primary,
      shape: shape,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
              tooltip: '탐색 메뉴 열기',
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              tooltip: '검색',
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
              tooltip: '즐겨찾기',
            ),
          ],
        ),
      ),
    );
  }
}
