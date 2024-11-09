import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy data tetap sama
  // Dummy data for all available items
  final List<Map<String, dynamic>> _allItems = [
    {
      'title': 'Cyber Enhancement X-1000',
      'type': 'Augmentation',
      'rating': 4.8,
      'price': '¥89,999',
      'image': 'https://picsum.photos/200/200?random=1',
    },
    {
      'title': 'Neural Interface V2',
      'type': 'Hardware',
      'rating': 4.5,
      'price': '¥125,000',
      'image': 'https://picsum.photos/200/200?random=2',
    },
    {
      'title': 'HoloLens Pro',
      'type': 'Gadget',
      'rating': 4.9,
      'price': '¥75,999',
      'image': 'https://picsum.photos/200/200?random=3',
    },
    {
      'title': 'Quantum Processor MK-II',
      'type': 'Hardware',
      'rating': 4.7,
      'price': '¥299,999',
      'image': 'https://picsum.photos/200/200?random=4',
    },
    {
      'title': 'BioLink Scanner',
      'type': 'Medical',
      'rating': 4.6,
      'price': '¥45,999',
      'image': 'https://picsum.photos/200/200?random=5',
    },
    {
      'title': 'Neural Boost Chip',
      'type': 'Augmentation',
      'rating': 4.4,
      'price': '¥67,999',
      'image': 'https://picsum.photos/200/200?random=6',
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery.isEmpty) {
      return _allItems;
    }
    return _allItems.where((item) {
      final title = item['title'].toString().toLowerCase();
      final type = item['type'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || type.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get safe area padding
    final safePadding = MediaQuery.of(context).padding;

    return Container(
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
      child: Column(
        children: [
          // Add safe area padding for top
          SizedBox(height: safePadding.top),
          // Search Field with platform-specific styling
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.cyanAccent),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Cyberwares...',
                hintStyle: TextStyle(color: Colors.cyanAccent.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.cyanAccent),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 15),
                  borderSide:
                      BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 15),
                  borderSide:
                      BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Platform.isIOS ? 10 : 15),
                  borderSide:
                      const BorderSide(color: Colors.pinkAccent, width: 2),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.7),
                // Platform specific padding
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: Platform.isIOS ? 12 : 16,
                ),
              ),
              // Platform specific keyboard type
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
            ),
          ),
          // List with platform-specific styling
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.cyanAccent.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found for "$_searchQuery"',
                          style: TextStyle(
                            color: Colors.cyanAccent.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    // Platform specific physics
                    physics: Platform.isIOS
                        ? const AlwaysScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    itemCount: _filteredItems.length,
                    padding: EdgeInsets.only(
                      bottom: safePadding.bottom +
                          16, // Add safe area padding for bottom
                    ),
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Platform.isIOS ? 10 : 15),
                          border: Border.all(
                            color: Colors.cyanAccent.withOpacity(0.3),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.blue.shade900.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.all(Platform.isIOS ? 12 : 16),
                          leading: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Platform.isIOS ? 8 : 10),
                            child: Image.network(
                              item['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              // Add loading placeholder
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.black26,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.cyanAccent),
                                    ),
                                  ),
                                );
                              },
                              // Add error placeholder
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.black26,
                                  child: const Icon(
                                    Icons.error_outline,
                                    color: Colors.cyanAccent,
                                  ),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.pinkAccent.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Platform.isIOS ? 6 : 8),
                                ),
                                child: Text(
                                  item['type'],
                                  style: const TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['rating'].toString(),
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Text(
                            item['price'],
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
