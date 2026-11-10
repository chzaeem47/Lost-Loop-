class ItemModel {
  final String id;
  final String title;
  final String color;
  final String location;
  final String date;
  final String imageUrl;

  const ItemModel({
    required this.id,
    required this.title,
    required this.color,
    required this.location,
    required this.date,
    required this.imageUrl,
  });

  static List<ItemModel> get mockItems => [
    const ItemModel(
      id: '1',
      title: 'Backpack',
      color: 'Black',
      location: 'Library Building',
      date: 'Sep 28, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=400&q=80',
    ),
    const ItemModel(
      id: '2',
      title: 'Wireless Earbuds',
      color: 'White',
      location: 'Science Block',
      date: 'Sep 27, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46?auto=format&fit=crop&w=400&q=80',
    ),
    const ItemModel(
      id: '3',
      title: 'Water Bottle',
      color: 'Blue',
      location: 'Cafeteria',
      date: 'Sep 26, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=400&q=80',
    ),
    const ItemModel(
      id: '4',
      title: 'Smartwatch',
      color: 'Silver',
      location: 'Gym Hall',
      date: 'Sep 25, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?auto=format&fit=crop&w=400&q=80',
    ),
    const ItemModel(
      id: '5',
      title: 'Laptop',
      color: 'Space Gray',
      location: 'Computer Lab',
      date: 'Sep 24, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=400&q=80',
    ),
    const ItemModel(
      id: '6',
      title: 'Umbrella',
      color: 'Red',
      location: 'Main Gate',
      date: 'Sep 23, 2025',
      imageUrl: 'https://images.unsplash.com/photo-1517479149777-5f3b6511d5ad?auto=format&fit=crop&w=400&q=80',
    ),
  ];
}
