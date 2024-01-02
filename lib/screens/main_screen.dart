import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/bars/bottom_navigation_bar_provider.dart';
import 'package:mobilni_zpevnik/bars/top_bar.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/tabs/home_tab.dart';
import 'package:mobilni_zpevnik/tabs/search_tab.dart';
import 'package:mobilni_zpevnik/tabs/songbooks_tab.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/bars/bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: true);

    return ScreenTemplate(
      appBar: const TopBar(),
      bottomBar: const BottomBar(),
      body: IndexedStack(
        index: bottomBarProvider.currentIndex,
        children: const [
          HomeTab(),
          SearchTab(),
          SongbooksTab(),
        ],
      ),
    );
  }
}
