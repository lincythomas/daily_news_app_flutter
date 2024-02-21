import 'package:daily_news_app/features/bookmark_news/presentation/bookmark_news_ui.dart';
import 'package:daily_news_app/features/news_list/presentation/news_list_ui.dart';
import 'package:daily_news_app/features/news_list/widgets/welcome_user.dart';
import 'package:daily_news_app/features/tech_crunch/presentation/tech_crunch_ui.dart';
import 'package:flutter/material.dart';

class BottomNavigationUI extends StatefulWidget {
  const BottomNavigationUI({super.key});

  @override
  State<BottomNavigationUI> createState() => _BottomNavigationUIState();
}

class _BottomNavigationUIState extends State<BottomNavigationUI> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        flexibleSpace: Expanded(
          child: Container(
              margin: const EdgeInsets.only(top: 60, left: 10),
              child: const WelcomeUser()),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
            showSelectedScreen(value, context);
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.newspaper_outlined), label: "TechCrunch"),
            NavigationDestination(
                icon: Icon(Icons.bookmark_outlined), label: "Saved")
          ]),
      body: IndexedStack(
          index: _currentIndex,
          children: [NewsListUI(), TechCrunchUI(), BookMarkNewsUI()]),
    );
  }

  Widget showSelectedScreen(int value, BuildContext context) {
    switch (value) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => NewsListUI(),
        // ));
        return NewsListUI();
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => TechCrunchUI(),
        // ));
        return TechCrunchUI();
      case 2:
        return BookMarkNewsUI();
      default:
        {
          return NewsListUI();
        }
    }
  }
}
