import 'package:flutter/material.dart';
import 'featured_grid.dart';
import 'featured_list.dart';

class FeaturedSection extends StatelessWidget {
  final bool isGridView;
  final Function() onViewToggle;
  final List<Map<String, dynamic>> featuredItems;

  const FeaturedSection({
    super.key,
    required this.isGridView,
    required this.onViewToggle,
    required this.featuredItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FEATURED TECH',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              TextButton(
                onPressed: onViewToggle,
                child: Text(
                  isGridView ? 'VIEW LIST' : 'VIEW GRID',
                  style: const TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        isGridView
            ? FeaturedGrid(featuredItems: featuredItems)
            : FeaturedList(featuredItems: featuredItems),
      ],
    );
  }
}
