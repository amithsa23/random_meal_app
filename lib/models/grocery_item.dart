/// GroceryItem represents an ingredient to buy
class GroceryItem {
  final String id;
  final String name;
  bool isChecked;

  GroceryItem({
    required this.id,
    required this.name,
    this.isChecked = false,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isChecked': isChecked,
    };
  }

  /// Create from JSON
  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isChecked: json['isChecked'] ?? false,
    );
  }
}

/// GroceryList manages the shopping list
class GroceryList {
  List<GroceryItem> items = [];

  /// Add an ingredient to the grocery list
  void addItem(String ingredient) {
    // Avoid duplicates
    if (!items.any((item) => item.name.toLowerCase() == ingredient.toLowerCase())) {
      items.add(GroceryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: ingredient,
      ));
    }
  }

  /// Add multiple ingredients at once
  void addItems(List<String> ingredients) {
    for (String ingredient in ingredients) {
      addItem(ingredient);
    }
  }

  /// Remove an item from the list
  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
  }

  /// Toggle item checked status
  void toggleItem(String id) {
    for (var item in items) {
      if (item.id == id) {
        item.isChecked = !item.isChecked;
        break;
      }
    }
  }

  /// Clear all items
  void clearAll() {
    items.clear();
  }

  /// Get unchecked items count
  int get uncheckedCount => items.where((item) => !item.isChecked).length;

  /// Get total items count
  int get totalCount => items.length;
}
