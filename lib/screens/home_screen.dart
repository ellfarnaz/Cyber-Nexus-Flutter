import 'package:flutter/material.dart';
import '../widgets/home/featured_section.dart';
import '../widgets/home/news_section.dart';
import '../widgets/home/welcome_section.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isGridView = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  Widget? _currentPage;

  final List<Map<String, dynamic>> _news = [
    {
      'title': 'New Cybernetic Regulations Announced',
      'date': '2077-03-15',
      'description':
          'The government has announced new regulations for cybernetic enhancements...',
      'image': 'https://picsum.photos/300/150?random=6',
    },
    {
      'title': 'Breakthrough in Neural Network Technology',
      'date': '2077-03-14',
      'description':
          'Scientists have achieved a major breakthrough in neural network integration...',
      'image': 'https://picsum.photos/300/150?random=7',
    },
    {
      'title': 'Black Market Cyber Raids Increase',
      'date': '2077-03-13',
      'description':
          'Authorities report an increase in illegal cybernetic modification clinics...',
      'image': 'https://picsum.photos/300/150?random=8',
    },
  ];

  final List<Map<String, dynamic>> _featuredItems = [
    {
      'title': 'Neural Implant X-99',
      'category': 'Cybernetic Enhancement',
      'price': '¥125,000',
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?random=1',
    },
    {
      'title': 'Quantum Processor',
      'category': 'Hardware',
      'price': '¥89,999',
      'rating': 4.5,
      'image': 'https://picsum.photos/200/200?random=2',
    },
    {
      'title': 'Holographic Display',
      'category': 'Augmented Reality',
      'price': '¥75,500',
      'rating': 4.9,
      'image': 'https://picsum.photos/200/200?random=3',
    },
    {
      'title': 'Cyber Deck Pro',
      'category': 'Hacking Tools',
      'price': '¥250,000',
      'rating': 4.7,
      'image': 'https://picsum.photos/200/200?random=4',
    },
    {
      'title': 'Memory Boost Chip',
      'category': 'Neural Enhancement',
      'price': '¥45,000',
      'rating': 4.6,
      'image': 'https://picsum.photos/200/200?random=5',
    },
  ];

  final List<Widget> _pages = const [
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _currentPage = _buildMainContent();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      bool slideLeft = index > _selectedIndex;
      _animationController.reset();

      _slideAnimation = Tween<Offset>(
        begin: Offset(slideLeft ? 1.0 : -1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _selectedIndex = index;

      if (index == 0) {
        _currentPage = _buildMainContent();
      } else {
        _currentPage = _pages[index - 1];
      }

      _animationController.forward();
    });
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
      if (_selectedIndex == 0) {
        _currentPage = _buildMainContent();
      }
    });
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeSection(),
          FeaturedSection(
            isGridView: _isGridView,
            onViewToggle: _toggleView,
            featuredItems: _featuredItems,
          ),
          NewsSection(news: _news),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'CYBER NEXUS',
        style: TextStyle(
          color: Colors.cyanAccent,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      actions: [
        if (_selectedIndex == 0)
          IconButton(
            icon: Icon(
              _isGridView ? Icons.list : Icons.grid_view,
              color: Colors.cyanAccent,
            ),
            onPressed: _toggleView,
          ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.cyanAccent.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.blue.shade900.withOpacity(0.2),
              Colors.purple.shade900.withOpacity(0.2),
            ],
          ),
        ),
        child: SlideTransition(
          position: _slideAnimation,
          child: _currentPage ?? _buildMainContent(),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }
}
