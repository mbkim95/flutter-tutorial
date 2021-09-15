import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

enum BottomNavigationDemoType {
  withLabels,
  withoutLabels,
}

class BottomNavigationDemo extends StatefulWidget {
  final String restorationId = 'bottom_navigation_labels_demo';
  late BottomNavigationDemoType type = BottomNavigationDemoType.withoutLabels;

  BottomNavigationDemo({Key? key}) : super(key: key);

  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  String _title() {
    switch (widget.type) {
      case BottomNavigationDemoType.withLabels:
        return 'Persistent Labels';
      case BottomNavigationDemoType.withoutLabels:
        return 'Selected Label';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = [
      BottomNavigationBarItem(icon: const Icon(Icons.add_comment), label: '댓글'),
      BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today), label: '캘린더'),
      BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle), label: '계정'),
      BottomNavigationBarItem(icon: const Icon(Icons.alarm_on), label: '알람'),
      BottomNavigationBarItem(
          icon: const Icon(Icons.camera_enhance), label: '카메라'),
    ];

    if (widget.type == BottomNavigationDemoType.withLabels) {
      bottomNavigationBarItems = bottomNavigationBarItems.sublist(
          0, bottomNavigationBarItems.length - 2);
      _currentIndex.value = _currentIndex.value
          .clamp(0, bottomNavigationBarItems.length - 1)
          .toInt();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_title()),
      ),
      body: Center(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, animation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _NavigationDestinationView(
              key: UniqueKey(),
              item: bottomNavigationBarItems[_currentIndex.value]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star),
        onPressed: () {
          setState(() {
            if (widget.type == BottomNavigationDemoType.withLabels) {
              widget.type = BottomNavigationDemoType.withoutLabels;
            } else {
              widget.type = BottomNavigationDemoType.withLabels;
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels:
            widget.type == BottomNavigationDemoType.withLabels,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textTheme.caption?.fontSize ?? 14.0,
        unselectedFontSize: textTheme.caption?.fontSize ?? 14.0,
        onTap: (index) {
          setState(() {
            _currentIndex.value = index;
          });
        },
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
        backgroundColor: colorScheme.primary,
      ),
    );
  }
}

class _NavigationDestinationView extends StatelessWidget {
  final BottomNavigationBarItem item;

  const _NavigationDestinationView({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExcludeSemantics(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/sample_image.png'),
              ),
            ),
          ),
        ),
        Center(
          child: IconTheme(
            data: const IconThemeData(color: Colors.white, size: 80),
            child: Semantics(
              label: item.label,
              child: item.icon,
            ),
          ),
        )
      ],
    );
  }
}
