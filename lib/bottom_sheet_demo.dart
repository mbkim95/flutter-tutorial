import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {
  const BottomSheetDemo({Key? key}) : super(key: key);

  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persistent bottom sheet'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: _PersistetBottomSheetDemo(),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Center(
              child: Text(
                'Header',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 21,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('item $index'),
              );
            },
          ))
        ],
      ),
    );
  }
}

class _PersistetBottomSheetDemo extends StatefulWidget {
  const _PersistetBottomSheetDemo({Key? key}) : super(key: key);

  @override
  _PersistetBottomSheetDemoState createState() =>
      _PersistetBottomSheetDemoState();
}

class _PersistetBottomSheetDemoState extends State<_PersistetBottomSheetDemo> {
  VoidCallback? _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showPersistentBottomSheet;
  }

  void _showPersistentBottomSheet() {
    setState(() {
      _showBottomSheetCallback = null;
    });

    Scaffold.of(context)
        .showBottomSheet((context) {
          return _BottomSheetContent();
        }, elevation: 25)
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showBottomSheetCallback = _showPersistentBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _showBottomSheetCallback,
        child: Text('SHOW BOTTOM SHEET'),
      ),
    );
  }
}

class _ModalBottomSheetDemo extends StatelessWidget {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return _BottomSheetContent();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showModalBottomSheet(context);
        },
        child: Text('SHOW BOTTOM SHEET'),
      ),
    );
  }
}
