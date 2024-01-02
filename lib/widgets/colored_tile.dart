import 'package:flutter/material.dart';

class ColoredTile extends StatelessWidget {
  final int index;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final IconData? icon;

  const ColoredTile({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.icon = Icons.music_note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    final Color tileColor = index.isOdd ? oddItemColor : evenItemColor;

    return ListTile(
      tileColor: tileColor,
      leading: Container(
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: tileColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: tileColor.withOpacity(0.5),
          ),
        ),
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
