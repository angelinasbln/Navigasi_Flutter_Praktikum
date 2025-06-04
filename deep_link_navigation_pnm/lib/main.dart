import 'package:flutter/material.dart';

// Kelas untuk merepresentasikan data item
class Item {
  final int id;
  final String name;

  Item({required this.id, required this.name});
}

// Kelas untuk parsing informasi rute
class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    // Rute root (/)
    if (uri.pathSegments.isEmpty) {
      return RoutePath.home();
    }

    // Rute /detail/:id
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'detail') {
      final id = int.tryParse(uri.pathSegments[1]);
      if (id != null) {
        return RoutePath.detail(id);
      }
    }

    // Rute /settings
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'settings') {
      return RoutePath.settings();
    }

    // Default ke home
    return RoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath path) {
    if (path.isHome) {
      return const RouteInformation(location: '/');
    }
    if (path.isDetail) {
      return RouteInformation(location: '/detail/${path.id}');
    }
    if (path.isSettings) {
      return const RouteInformation(location: '/settings');
    }
    return const RouteInformation(location: '/');
  }
}

// Kelas untuk konfigurasi rute
class RoutePath {
  final bool isHome;
  final bool isSettings;
  final int? id;

  RoutePath.home()
      : isHome = true,
        isSettings = false,
        id = null;

  RoutePath.detail(this.id)
      : isHome = false,
        isSettings = false;

  RoutePath.settings()
      : isHome = false,
        isSettings = true,
        id = null;

  bool get isDetail => !isHome && !isSettings;
}

// Kelas untuk router delegate
class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int? _selectedItemId;
  bool _showSettings = false;

  final List<Item> _items = [
    Item(id: 1, name: 'Item 1'),
    Item(id: 2, name: 'Item 2'),
    Item(id: 3, name: 'Item 3'),
  ];

  // Mengatur item yang dipilih
  void selectItem(int id) {
    _selectedItemId = id;
    _showSettings = false;
    notifyListeners();
  }

  // Kembali ke home
  void goHome() {
    _selectedItemId = null;
    _showSettings = false;
    notifyListeners();
  }

  // Tampilkan layar settings
  void showSettings() {
    _selectedItemId = null;
    _showSettings = true;
    notifyListeners();
  }

  @override
  RoutePath get currentConfiguration {
    if (_showSettings) {
      return RoutePath.settings();
    }
    if (_selectedItemId == null) {
      return RoutePath.home();
    }
    return RoutePath.detail(_selectedItemId);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey('HomeScreen'),
          child: HomeScreen(
            items: _items,
            onItemSelected: selectItem,
            onSettingsSelected: showSettings, // Tambahkan callback untuk settings
          ),
        ),
        if (_selectedItemId != null)
          MaterialPage(
            key: ValueKey('DetailScreen-$_selectedItemId'),
            child: DetailScreen(
              item: _items.firstWhere((item) => item.id == _selectedItemId),
              onBack: goHome,
            ),
          ),
        if (_showSettings)
          const MaterialPage(
            key: ValueKey('SettingsScreen'),
            child: SettingsScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_showSettings) {
          _showSettings = false;
          notifyListeners();
          return true;
        }
        if (_selectedItemId != null) {
          goHome();
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    if (path.isHome) {
      _selectedItemId = null;
      _showSettings = false;
    } else if (path.isDetail && path.id != null) {
      _selectedItemId = path.id;
      _showSettings = false;
    } else if (path.isSettings) {
      _showSettings = true;
      _selectedItemId = null;
    }
  }
}

// Aplikasi utama
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deep Linking App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}

// Layar Utama (HomeScreen)
class HomeScreen extends StatelessWidget {
  final List<Item> items;
  final Function(int) onItemSelected;
  final VoidCallback onSettingsSelected; // Callback untuk tombol settings

  const HomeScreen({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.onSettingsSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: onSettingsSelected,
            tooltip: 'Settings',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('ID: ${item.id}'),
            onTap: () => onItemSelected(item.id),
            trailing: const Icon(Icons.arrow_forward),
          );
        },
      ),
    );
  }
}

// Layar Detail (DetailScreen)
class DetailScreen extends StatelessWidget {
  final Item item;
  final VoidCallback onBack;

  const DetailScreen({
    super.key,
    required this.item,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${item.name}'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Item: ${item.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'ID: ${item.id}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Layar Settings baru
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Settings Screen',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
