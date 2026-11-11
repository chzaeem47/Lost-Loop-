import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../models/item_model.dart';

class ReportFoundScreen extends StatefulWidget {
  const ReportFoundScreen({super.key});

  @override
  State<ReportFoundScreen> createState() => _ReportFoundScreenState();
}

class _ReportFoundScreenState extends State<ReportFoundScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers & Form Values
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String? _selectedCategory;
  String? _selectedLocation;
  DateTime? _selectedDate;
  bool _isSubmitting = false;

  // Photo state (Required for found item)
  String? _attachedPhotoPath; // Simulated attached photo name/url

  final List<String> _categories = [
    'Bag',
    'Electronics',
    'Keys',
    'Wallet',
    'Books',
    'Other',
  ];

  final List<String> _locations = [
    'Library Building',
    'Science Block',
    'Cafeteria',
    'Gym Hall',
    'Computer Lab',
    'Main Gate',
    'Student Center',
    'Other Campus Area',
  ];

  @override
  void dispose() {
    _itemNameController.dispose();
    _colorController.dispose();
    _descriptionController.dispose();
    _detailsController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // Date Picker Handler
  Future<void> _pickDate() async {
    final DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.darkNavy,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Time Picker Handler
  Future<void> _pickTime() async {
    final TimeOfDay initialTime = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.darkNavy,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  // Photo Selector Simulation
  void _selectPhoto(String source) {
    setState(() {
      _attachedPhotoPath =
          "https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46?auto=format&fit=crop&w=400&q=80";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Photo selected from $source",
          style: GoogleFonts.tinos(
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Form Submission Handler
  void _submitReport() {
    if (_attachedPhotoPath == null) {
      _showToast("Please upload an item photo (Required for AI visual matching)");
      return;
    }

    if (!_formKey.currentState!.validate()) {
      _showToast("Please fill in all required fields");
      return;
    }

    if (_selectedCategory == null) {
      _showToast("Please select an item category");
      return;
    }

    if (_selectedLocation == null) {
      _showToast("Please select the found location");
      return;
    }

    if (_selectedDate == null) {
      _showToast("Please select date found");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate AI visual scanning & database submission
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      _showSuccessAndMatchBottomSheet();
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.tinos(
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.darkNavy,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Success & Potential Lost Reports Match Bottom Sheet
  void _showSuccessAndMatchBottomSheet() {
    final matchingItems = ItemModel.mockItems.where((item) {
      final matchesCategory = _selectedCategory != null &&
          item.title.toLowerCase().contains(_selectedCategory!.toLowerCase());
      final matchesLocation = _selectedLocation != null &&
          item.location.toLowerCase().contains(_selectedLocation!.toLowerCase());
      return matchesCategory || matchesLocation;
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicator bar
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              // Success Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 42,
                ),
              ),
              const SizedBox(height: 14),

              Text(
                "Found Item Report Submitted! 🎉",
                style: GoogleFonts.tinos(
                  color: AppColors.darkNavy,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),

              Text(
                "Your item is now live in the Found Items directory. LostLoop AI has cross-matched it with existing lost reports.",
                style: GoogleFonts.tinos(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              if (matchingItems.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Matching Lost Reports Found (${matchingItems.length})",
                    style: GoogleFonts.tinos(
                      color: AppColors.primaryBlue,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          matchingItems.first.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              matchingItems.first.title,
                              style: GoogleFonts.tinos(
                                color: AppColors.darkNavy,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Lost at: ${matchingItems.first.location}",
                              style: GoogleFonts.tinos(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "98% AI Match",
                          style: GoogleFonts.tinos(
                            color: Colors.white,
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppColors.primaryBlue,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "No direct lost match yet. Your listing is now discoverable to all students, and LostLoop AI will notify any future matches!",
                          style: GoogleFonts.tinos(
                            color: AppColors.darkNavy,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Done Button
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
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close sheet
                    Navigator.pop(context); // Return to home
                  },
                  child: Text(
                    "Back to Home",
                    style: GoogleFonts.tinos(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = _selectedDate == null
        ? "Select date found"
        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 50,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Report a Found Item",
                      style: GoogleFonts.tinos(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48, right: 12, top: 4),
                  child: Text(
                    "Upload a photo and details to help return this item to its owner.",
                    style: GoogleFonts.tinos(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form Body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PROMINENT PHOTO UPLOAD AREA (Required)
                    _buildLabel("Upload Item Photo", isRequired: true),
                    const SizedBox(height: 8),

                    if (_attachedPhotoPath == null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColors.primaryBlue.withOpacity(0.4),
                            width: 1.6,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_a_photo_rounded,
                                color: AppColors.primaryBlue,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Add a Clear Photo of the Item",
                              style: GoogleFonts.tinos(
                                color: AppColors.darkNavy,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Required for AI visual analysis and owner verification",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tinos(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primaryBlue,
                                    side: const BorderSide(
                                      color: AppColors.primaryBlue,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _selectPhoto("Camera"),
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 18,
                                  ),
                                  label: Text(
                                    "Take Photo",
                                    style: GoogleFonts.tinos(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _selectPhoto("Gallery"),
                                  icon: const Icon(
                                    Icons.photo_library_rounded,
                                    size: 18,
                                  ),
                                  label: Text(
                                    "Gallery",
                                    style: GoogleFonts.tinos(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.green.withOpacity(0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18),
                              ),
                              child: Image.network(
                                _attachedPhotoPath!,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Photo Attached (Ready for AI)",
                                        style: GoogleFonts.tinos(
                                          color: AppColors.darkNavy,
                                          fontSize: 13.5,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            _selectPhoto("Gallery"),
                                        child: Text(
                                          "Replace",
                                          style: GoogleFonts.tinos(
                                            color: AppColors.primaryBlue,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _attachedPhotoPath = null;
                                          });
                                        },
                                        child: Text(
                                          "Remove",
                                          style: GoogleFonts.tinos(
                                            color: Colors.redAccent,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // 1. Item Name (Required)
                    _buildLabel("Item Name", isRequired: true),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _itemNameController,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Item name is required";
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: "e.g. Wireless Earbuds, Blue Wallet",
                        prefixIcon: Icons.shopping_bag_outlined,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 2. Item Category (Required)
                    _buildLabel("Item Category", isRequired: true),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primaryBlue,
                      ),
                      dropdownColor: Colors.white,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: _buildInputDecoration(
                        hintText: "Select category",
                        prefixIcon: Icons.category_outlined,
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedCategory = val;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // 3. Color (Required)
                    _buildLabel("Color", isRequired: true),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _colorController,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Color is required";
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: "e.g. White, Black, Silver",
                        prefixIcon: Icons.palette_outlined,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 4. Short Description (Required)
                    _buildLabel("Short Description", isRequired: true),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Short description is required";
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText:
                            "Describe item condition, exactly where you found it...",
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 5. Found Location (Required)
                    _buildLabel("Found Location", isRequired: true),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedLocation,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primaryBlue,
                      ),
                      dropdownColor: Colors.white,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: _buildInputDecoration(
                        hintText: "Select campus location",
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      items: _locations.map((loc) {
                        return DropdownMenuItem(
                          value: loc,
                          child: Text(loc),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedLocation = val;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // 6 & 7. Date Found (Required) & Time Found (Optional)
                    Row(
                      children: [
                        // Date Found
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Date Found", isRequired: true),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: _pickDate,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_rounded,
                                        size: 18,
                                        color: AppColors.primaryBlue,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          formattedDate,
                                          style: GoogleFonts.tinos(
                                            color: _selectedDate == null
                                                ? Colors.grey.shade500
                                                : AppColors.darkNavy,
                                            fontSize: 13.5,
                                            fontStyle: FontStyle.italic,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Time Found (Optional)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Time Found", isRequired: false),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: _pickTime,
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _timeController,
                                    style: GoogleFonts.tinos(
                                      color: AppColors.darkNavy,
                                      fontSize: 13.5,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    decoration: _buildInputDecoration(
                                      hintText: "e.g. 02:15 PM",
                                      prefixIcon: Icons.access_time_rounded,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 8. Brand or Distinguishing Details (Optional)
                    _buildLabel("Brand / Details (Optional)", isRequired: false),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _detailsController,
                      style: GoogleFonts.tinos(
                        color: AppColors.darkNavy,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: _buildInputDecoration(
                        hintText: "e.g. Apple, case sticker, serial number...",
                        prefixIcon: Icons.style_outlined,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Submit Found Report Primary Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shadowColor: AppColors.primaryBlue.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _isSubmitting ? null : _submitReport,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                "Submit Found Report",
                                style: GoogleFonts.tinos(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Label Builder Helper
  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.tinos(
            color: AppColors.darkNavy,
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isRequired)
          Text(
            " *",
            style: GoogleFonts.tinos(
              color: Colors.redAccent,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  // Input Decoration Helper
  InputDecoration _buildInputDecoration({
    required String hintText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.tinos(
        color: Colors.grey.shade400,
        fontSize: 14,
        fontStyle: FontStyle.italic,
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: AppColors.primaryBlue,
              size: 20,
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primaryBlue,
          width: 1.8,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.2,
        ),
      ),
    );
  }
}
