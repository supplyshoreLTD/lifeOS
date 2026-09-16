import 'package:flutter/cupertino.dart';

void main() {
  runApp(const LifeOSApp());
}

class LifeOSApp extends StatelessWidget {
  const LifeOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'LifeOS',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> _tabs = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(CupertinoIcons.house),
      activeIcon: Icon(CupertinoIcons.house_fill),
    ),
    BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(CupertinoIcons.search),
    ),
    BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(CupertinoIcons.settings),
      activeIcon: Icon(CupertinoIcons.settings_solid),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: _tabs,
      ),
      tabBuilder: (context, index) {
        return switch (index) {
          1 => const SearchPage(),
          2 => const SettingsPage(),
          _ => const DashboardPage(),
        };
      },
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('LifeOS'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '$_counter',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
              CupertinoButton.filled(
                onPressed: _incrementCounter,
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Search'),
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoSearchTextField(
            placeholder: 'Search LifeOS',
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('Account'),
              children: const [
                CupertinoListTile(
                  title: Text('Profile'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  title: Text('Notifications'),
                  trailing: CupertinoListTileChevron(),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('About'),
              children: const [
                CupertinoListTile(
                  title: Text('Version'),
                  trailing: Text('1.0.0'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
