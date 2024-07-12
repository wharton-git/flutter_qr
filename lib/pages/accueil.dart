import 'package:flutter/material.dart';
import 'package:flutter_base_project/pages/scan.dart';
import 'package:flutter_base_project/pages/generer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget currentPage;
    switch (currentIndex) {
      case 0:
        currentPage = const Home();
      case 1:
        currentPage = const Scan();
      case 2:
        currentPage = const Generer();
      // case 3:
      //   currentPage = const Generer();
      default:
        throw UnimplementedError('No widget for an index of $currentIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: currentPage,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                    child: BottomNavigationBar(
                  // fixedColor: colorScheme.onSecondaryContainer,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code_scanner),
                      label: 'Scan',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.edit),
                      label: 'Generate',
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.history),
                    //   label: 'History',
                    // ),
                  ],
                  currentIndex: currentIndex,
                  onTap: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                )),
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.qr_code_scanner),
                        label: Text('Scan'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.edit),
                        label: Text('Generate'),
                      ),
                      // NavigationRailDestination(
                      //   icon: Icon(Icons.history),
                      //   label: Text('History'),
                      // ),
                    ],
                    selectedIndex: currentIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Center(
            child: Text('Welcome to QR-Scanner'),
          ),
        ),
      ),
    );
  }
}
