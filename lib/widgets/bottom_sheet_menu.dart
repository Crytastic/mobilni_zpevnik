import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/widgets/menu_option.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';

class BottomSheetMenu extends StatelessWidget {
  final Widget menuHeader;
  final List<MenuOption> menuOptions;

  const BottomSheetMenu({
    Key? key,
    required this.menuOptions,
    required this.menuHeader,
  }) : super(key: key);

  static void show(
      BuildContext context, Widget menuHeader, List<MenuOption> menuOptions) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetMenu(menuHeader: menuHeader, menuOptions: menuOptions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SmallGap(),
        _buildSwipeIndicator(),
        menuHeader,
        const Divider(height: 1),
        for (var option in menuOptions)
          ListTile(
            leading: Icon(option.icon),
            title: Text(option.title),
            onTap: option.onTap,
          ),
      ],
    );
  }

  Widget _buildSwipeIndicator() {
    return Container(
      width: 40.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
