import 'package:flutter/material.dart';

import 'lost_items_screen.dart';

class FoundItemsScreen extends StatelessWidget {
  const FoundItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LostItemsScreen(initialSegment: 1);
  }
}
