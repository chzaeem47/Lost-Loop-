class ItemModel {
  final String id;
  final String title;
  final String category;
  final String color;
  final String location;
  final String date;
  final String imageUrl;
  final String status;
  final bool isLost;
  final String description;

  const ItemModel({
    required this.id,
    required this.title,
    this.category = 'Other',
    required this.color,
    required this.location,
    required this.date,
    required this.imageUrl,
    this.status = 'Still Lost',
    this.isLost = true,
    this.description = 'Item reported in campus area. Contact if you have information or claims.',
  });

  static List<ItemModel> get mockItems => [
    const ItemModel(
      id: '1',
      title: 'Black Backpack',
      category: 'Bag',
      color: 'Black',
      location: 'Library Building',
      date: 'Sep 28, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=400&q=80',
      status: 'Still Lost',
      isLost: true,
      description: 'Black SwissGear backpack containing notebooks and a blue pencil case. Last seen on 2nd floor library reading table.',
    ),
    const ItemModel(
      id: '2',
      title: 'Wireless Earbuds',
      category: 'Electronics',
      color: 'White',
      location: 'Science Block',
      date: 'Sep 27, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46?auto=format&fit=crop&w=400&q=80',
      status: 'Found & Unclaimed',
      isLost: false,
      description: 'AirPods Pro white charging case found near Physics Lab 3 entrance on bench.',
    ),
    const ItemModel(
      id: '3',
      title: 'Water Bottle',
      category: 'Other',
      color: 'Blue',
      location: 'Cafeteria',
      date: 'Sep 26, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=400&q=80',
      status: 'Still Lost',
      isLost: true,
      description: 'HydroFlask metallic blue 32oz water bottle with NASA sticker near the top lid.',
    ),
    const ItemModel(
      id: '4',
      title: 'Smartwatch',
      category: 'Electronics',
      color: 'Silver',
      location: 'Gym Hall',
      date: 'Sep 25, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?auto=format&fit=crop&w=400&q=80',
      status: 'Still Lost',
      isLost: true,
      description: 'Silver Apple Watch Series 7 with black sport band. Left in locker room 4.',
    ),
    const ItemModel(
      id: '5',
      title: 'MacBook Pro',
      category: 'Electronics',
      color: 'Space Gray',
      location: 'Computer Lab',
      date: 'Sep 24, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=400&q=80',
      status: 'Found & Unclaimed',
      isLost: false,
      description: '14-inch Space Gray MacBook Pro with anime sticker on right wrist rest.',
    ),
    const ItemModel(
      id: '6',
      title: 'Compact Umbrella',
      category: 'Other',
      color: 'Red',
      location: 'Main Gate',
      date: 'Sep 23, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1517479149777-5f3b6511d5ad?auto=format&fit=crop&w=400&q=80',
      status: 'Still Lost',
      isLost: true,
      description: 'Red automatic folding umbrella with wooden handle. Forgot at security gate umbrella stand.',
    ),
  ];
}
