import 'package:flutter/material.dart';

enum BannerDemoAction { reset, showMultipleActions, showLeading }

class BannerDemo extends StatefulWidget {
  const BannerDemo({Key? key}) : super(key: key);

  @override
  _BannerDemoState createState() => _BannerDemoState();
}

class _BannerDemoState extends State<BannerDemo> with RestorationMixin {
  static const _itemCount = 20;
  final RestorableBool _displayBanner = RestorableBool(true);
  final RestorableBool _showMultipleActions = RestorableBool(true);
  final RestorableBool _showLeading = RestorableBool(true);

  @override
  String? get restorationId => 'banner_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_displayBanner, 'display_banner');
    registerForRestoration(_showMultipleActions, 'show_multiple_actions');
    registerForRestoration(_showLeading, 'show_leading');
  }

  @override
  void dispose() {
    _displayBanner.dispose();
    _showMultipleActions.dispose();
    _showLeading.dispose();
    super.dispose();
  }

  void handleDemoAction(BannerDemoAction action) {
    setState(() {
      switch (action) {
        case BannerDemoAction.reset:
          _displayBanner.value = true;
          _showMultipleActions.value = true;
          _showLeading.value = true;
          break;
        case BannerDemoAction.showMultipleActions:
          _showMultipleActions.value = !_showMultipleActions.value;
          break;
        case BannerDemoAction.showLeading:
          _showLeading.value = !_showLeading.value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final banner = MaterialBanner(
      content: Text('다른 기기에서 비밀번호가 업데이트 되었습니다. 다시 로그인 해주세요.'),
      leading: _showLeading.value
          ? CircleAvatar(
              backgroundColor: colorScheme.primary,
              child: Icon(Icons.access_alarm, color: colorScheme.onPrimary),
            )
          : null,
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                _displayBanner.value = false;
              });
            },
            child: Text('로그인')),
        if (_showMultipleActions.value)
          TextButton(
              onPressed: () {
                setState(() {
                  _displayBanner.value = false;
                });
              },
              child: Text('닫기'))
      ],
      backgroundColor: colorScheme.background,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Banner Demo'),
        actions: [
          PopupMenuButton<BannerDemoAction>(
              onSelected: handleDemoAction,
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: BannerDemoAction.reset, child: Text('배너 재설정')),
                    PopupMenuDivider(),
                    CheckedPopupMenuItem(
                        value: BannerDemoAction.showMultipleActions,
                        checked: _showMultipleActions.value,
                        child: Text('여러 작업')),
                    CheckedPopupMenuItem(
                        value: BannerDemoAction.showLeading,
                        checked: _showLeading.value,
                        child: Text('앞 부분 아이콘')),
                  ])
        ],
      ),
      body: ListView.builder(
          restorationId: 'banner_demo_list_view',
          itemCount: _displayBanner.value ? _itemCount + 1 : _itemCount,
          itemBuilder: (context, index) {
            if (index == 0 && _displayBanner.value) {
              return banner;
            }
            return ListTile(
              title: Text('항목 ${_displayBanner.value ? index : index + 1}'),
            );
          }),
    );
  }
}
