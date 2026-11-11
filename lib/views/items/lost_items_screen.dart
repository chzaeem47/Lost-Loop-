import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../models/item_model.dart';
import '../home/widgets/home_header.dart';
import '../report/report_found_screen.dart';
import '../report/report_lost_screen.dart';

class LostItemsScreen extends StatefulWidget {
  final int initialSegment; // 0 = Lost Items, 1 = Found Items

  const LostItemsScreen({
    super.key,
    this.initialSegment = 0,
  });

  @override
  State<LostItemsScreen> createState() => _LostItemsScreenState();
}

class _LostItemsScreenState extends State<LostItemsScreen> {
  late int _selectedSegment;

  // Search & Filter state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedCategory = "All";
  String _selectedColor = "All";
  String _selectedLocation = "All";
  String _sortOption = "Newest First";

  final List<String> _categories = [
    'All',
    'Bag',
    'Electronics',
    'Keys',
    'Wallet',
    'Books',
    'Other',
  ];

  final List<String> _colors = [
    'All',
    'Black',
    'White',
    'Blue',
    'Silver',
    'Red',
  ];

  final List<String> _locations = [
    'All',
    'Library Building',
    'Science Block',
    'Cafeteria',
    'Gym Hall',
    'Computer Lab',
    'Main Gate',
  ];

  final List<String> _sortOptions = [
    'Newest First',
    'Relevance',
    'Oldest First',
    'Location A-Z',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSegment = widget.initialSegment;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter Active Helper
  bool get _hasActiveFilters =>
      _selectedCategory != "All" ||
      _selectedColor != "All" ||
      _selectedLocation != "All";

  // Reset Filters
  void _resetFilters() {
    setState(() {
      _selectedCategory = "All";
      _selectedColor = "All";
      _selectedLocation = "All";
      _searchController.clear();
      _searchQuery = "";
    });
  }

  // Filtered Item List Computation
  List<ItemModel> get _filteredItems {
    final allMock = ItemModel.mockItems;
    List<ItemModel> list = allMock.where((item) {
      // Segment filter: 0 = Lost items, 1 = Found items
      final matchesSegment = _selectedSegment == 0 ? item.isLost : !item.isLost;
      if (!matchesSegment) return false;

      // Search query match
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesTitle = item.title.toLowerCase().contains(query);
        final matchesLoc = item.location.toLowerCase().contains(query);
        final matchesColor = item.color.toLowerCase().contains(query);
        final matchesCat = item.category.toLowerCase().contains(query);
        if (!matchesTitle && !matchesLoc && !matchesColor && !matchesCat) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != "All" &&
          item.category.toLowerCase() != _selectedCategory.toLowerCase()) {
        return false;
      }

      // Color filter
      if (_selectedColor != "All" &&
          !item.color.toLowerCase().contains(_selectedColor.toLowerCase())) {
        return false;
      }

      // Location filter
      if (_selectedLocation != "All" &&
          item.location.toLowerCase() != _selectedLocation.toLowerCase()) {
        return false;
      }

      return true;
    }).toList();

    // Sorting
    if (_sortOption == "Oldest First") {
      list = list.reversed.toList();
    } else if (_sortOption == "Location A-Z") {
      list.sort((a, b) => a.location.compareTo(b.location));
    }

    return list;
  }

  // Filter Bottom Sheet
  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle Line
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedSegment == 0
                            ? "Filter Lost Items"
                            : "Filter Found Items",
                        style: GoogleFonts.tinos(
                          color: AppColors.darkNavy,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setSheetState(() {
                            _selectedCategory = "All";
                            _selectedColor = "All";
                            _selectedLocation = "All";
                          });
                          setState(() {});
                        },
                        child: Text(
                          "Reset All",
                          style: GoogleFonts.tinos(
                            color: Colors.redAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 1. Category Filter
                  _buildFilterSectionTitle("Item Category"),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        selectedColor: AppColors.primaryBlue,
                        backgroundColor: const Color(0xFFF1F5F9),
                        labelStyle: GoogleFonts.tinos(
                          color: isSelected ? Colors.white : AppColors.darkNavy,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        onSelected: (selected) {
                          setSheetState(() {
                            _selectedCategory = cat;
                          });
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // 2. Color Filter
                  _buildFilterSectionTitle("Color"),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _colors.map((c) {
                      final isSelected = _selectedColor == c;
                      return ChoiceChip(
                        label: Text(c),
                        selected: isSelected,
                        selectedColor: AppColors.primaryBlue,
                        backgroundColor: const Color(0xFFF1F5F9),
                        labelStyle: GoogleFonts.tinos(
                          color: isSelected ? Colors.white : AppColors.darkNavy,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        onSelected: (selected) {
                          setSheetState(() {
                            _selectedColor = c;
                          });
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // 3. Location Filter
                  _buildFilterSectionTitle("Campus Location"),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    dropdownColor: Colors.white,
                    style: GoogleFonts.tinos(
                      color: AppColors.darkNavy,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                    items: _locations.map((loc) {
                      return DropdownMenuItem(
                        value: loc,
                        child: Text(loc),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setSheetState(() {
                          _selectedLocation = val;
                        });
                        setState(() {});
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Apply Filters",
                        style: GoogleFonts.tinos(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Item Details Modal Sheet
  void _openItemDetailsModal(ItemModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Large Image Preview
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  item.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: item.isLost
                          ? Colors.redAccent.withOpacity(0.12)
                          : Colors.green.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: item.isLost
                            ? Colors.redAccent.withOpacity(0.3)
                            : Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      item.status,
                      style: GoogleFonts.tinos(
                        color: item.isLost ? Colors.redAccent : Colors.green,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                "${item.category} • ${item.color}",
                style: GoogleFonts.tinos(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Location: ${item.location}",
                    style: GoogleFonts.tinos(
                      color: AppColors.darkNavy,
                      fontSize: 13.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 15,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.date,
                    style: GoogleFonts.tinos(
                      color: AppColors.darkNavy,
                      fontSize: 13.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                "Description:",
                style: GoogleFonts.tinos(
                  color: AppColors.darkNavy,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: GoogleFonts.tinos(
                  color: Colors.grey.shade700,
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          item.isLost
                              ? "Contact request sent for ${item.title}!"
                              : "Ownership claim initiated for ${item.title}!",
                          style: GoogleFonts.tinos(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    );
                  },
                  icon: Icon(
                    item.isLost
                        ? Icons.send_rounded
                        : Icons.verified_user_outlined,
                    size: 18,
                  ),
                  label: Text(
                    item.isLost ? "I Found This Item!" : "Claim This Item",
                    style: GoogleFonts.tinos(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayedItems = _filteredItems;

    return Scaffold(
      appBar: const HomeHeader(), // Exact same AppBar as main screen
      backgroundColor: AppColors.screenBg,
      body: Column(
        children: [
          // Segmented Control Header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSegment = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedSegment == 0
                              ? AppColors.primaryBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: Text(
                            "Lost Items",
                            style: GoogleFonts.tinos(
                              color: _selectedSegment == 0
                                  ? Colors.white
                                  : AppColors.darkNavy,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSegment = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedSegment == 1
                              ? AppColors.primaryBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: Text(
                            "Found Items",
                            style: GoogleFonts.tinos(
                              color: _selectedSegment == 1
                                  ? Colors.white
                                  : AppColors.darkNavy,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search & Filter Row + Sort Dropdown
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search name, location...",
                        hintStyle: GoogleFonts.tinos(
                          color: Colors.grey.shade400,
                          fontSize: 13.5,
                          fontStyle: FontStyle.italic,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.primaryBlue,
                          size: 20,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = "";
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  initialValue: _sortOption,
                  icon: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                    ),
                    child: const Icon(
                      Icons.swap_vert_rounded,
                      color: AppColors.primaryBlue,
                      size: 22,
                    ),
                  ),
                  onSelected: (val) {
                    setState(() {
                      _sortOption = val;
                    });
                  },
                  itemBuilder: (context) {
                    return _sortOptions.map((opt) {
                      return PopupMenuItem(
                        value: opt,
                        child: Text(
                          opt,
                          style: GoogleFonts.tinos(
                            color: AppColors.darkNavy,
                            fontSize: 13.5,
                            fontStyle: FontStyle.italic,
                            fontWeight: _sortOption == opt
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
                const SizedBox(width: 8),
                Stack(
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: _hasActiveFilters
                            ? AppColors.primaryBlue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _hasActiveFilters
                              ? AppColors.primaryBlue
                              : const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune_rounded,
                          color: _hasActiveFilters
                              ? Colors.white
                              : AppColors.primaryBlue,
                          size: 20,
                        ),
                        onPressed: _openFilterBottomSheet,
                      ),
                    ),
                    if (_hasActiveFilters)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Fully Responsive GridView of Items
          Expanded(
            child: displayedItems.isEmpty
                ? _buildEmptyState()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int crossAxisCount = 3;
                      if (width > 900) {
                        crossAxisCount = 5;
                      } else if (width > 600) {
                        crossAxisCount = 4;
                      } else if (width < 360) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: displayedItems.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.54,
                        ),
                        itemBuilder: (context, index) {
                          final item = displayedItems[index];

                          String? foundBadgeText;
                          Color foundBadgeBg = const Color(0xFFF0FDF4);
                          Color foundBadgeTextCol = const Color(0xFF16A34A);
                          Color foundBadgeBorder = const Color(0xFFBBF7D0);

                          if (!item.isLost) {
                            if (item.id == '2') {
                              foundBadgeText = "Potential Match";
                              foundBadgeBg = const Color(0xFFECFDF5);
                              foundBadgeTextCol = const Color(0xFF059669);
                              foundBadgeBorder = const Color(0xFFA7F3D0);
                            } else {
                              foundBadgeText = "New";
                              foundBadgeBg = const Color(0xFFEFF6FF);
                              foundBadgeTextCol = const Color(0xFF2563EB);
                              foundBadgeBorder = const Color(0xFFBFDBFE);
                            }
                          } else {
                            foundBadgeText = "Still Lost";
                            foundBadgeBg = const Color(0xFFFEF2F2);
                            foundBadgeTextCol = const Color(0xFFDC2626);
                            foundBadgeBorder = const Color(0xFFFECACA);
                          }

                          return GestureDetector(
                            onTap: () => _openItemDetailsModal(item),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE8EEF8),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.darkNavy.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 55,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: Image.network(
                                                item.imageUrl,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  color:
                                                      const Color(0xFFF1F5F9),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      color:
                                                          Color(0xFF94A3B8),
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: foundBadgeBg,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: foundBadgeBorder,
                                                  width: 0.8,
                                                ),
                                              ),
                                              child: Text(
                                                foundBadgeText,
                                                style: GoogleFonts.tinos(
                                                  color: foundBadgeTextCol,
                                                  fontSize: 8.5,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Expanded(
                                      flex: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.tinos(
                                                    color: AppColors.darkNavy,
                                                    fontSize: 13,
                                                    fontStyle:
                                                        FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${item.category} • ${item.color}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.tinos(
                                                    color: const Color(
                                                      0xFF708099,
                                                    ),
                                                    fontSize: 10.5,
                                                    fontStyle:
                                                        FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .location_on_rounded,
                                                      size: 11.5,
                                                      color: Color(
                                                        0xFF708099,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Expanded(
                                                      child: Text(
                                                        item.location,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.tinos(
                                                          color: const Color(
                                                            0xFF708099,
                                                          ),
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_today_rounded,
                                                      size: 10.5,
                                                      color: Color(
                                                        0xFF708099,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Expanded(
                                                      child: Text(
                                                        item.date,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.tinos(
                                                          color: const Color(
                                                            0xFF708099,
                                                          ),
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.tinos(
        color: AppColors.darkNavy,
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmptyState() {
    final isLostTab = _selectedSegment == 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLostTab
                  ? Icons.search_off_rounded
                  : Icons.find_in_page_outlined,
              color: AppColors.primaryBlue,
              size: 44,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            isLostTab ? "No lost items found" : "No found items match filter",
            style: GoogleFonts.tinos(
              color: AppColors.darkNavy,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isLostTab
                ? "We couldn't find any lost items matching your search or filters."
                : "We couldn't find any found items matching your active search or filters.",
            textAlign: TextAlign.center,
            style: GoogleFonts.tinos(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _resetFilters,
                child: Text(
                  "Reset Filters",
                  style: GoogleFonts.tinos(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (isLostTab) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportLostScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportFoundScreen(),
                      ),
                    );
                  }
                },
                child: Text(
                  isLostTab ? "Report Lost Item" : "Report Found Item",
                  style: GoogleFonts.tinos(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
