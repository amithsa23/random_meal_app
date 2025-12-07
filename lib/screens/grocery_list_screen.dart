import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/grocery_item.dart';

/// GroceryListScreen displays and manages the shopping list
class GroceryListScreen extends StatefulWidget {
  final GroceryList groceryList;

  const GroceryListScreen({super.key, required this.groceryList});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  @override
  Widget build(BuildContext context) {
    final uncheckedItems = widget.groceryList.items.where((item) => !item.isChecked).toList();
    final checkedItems = widget.groceryList.items.where((item) => item.isChecked).toList();

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shopping List',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.groceryList.uncheckedCount} items to buy',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (widget.groceryList.items.isNotEmpty)
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 28,
                      child: Text(
                        '${widget.groceryList.items.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: widget.groceryList.items.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // To Buy section
                        if (uncheckedItems.isNotEmpty) ...[
                          Text(
                            'To Buy',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...uncheckedItems.map((item) => _buildGroceryItem(item)),
                          const SizedBox(height: 24),
                        ],

                        // Purchased section
                        if (checkedItems.isNotEmpty) ...[
                          Text(
                            'Purchased (${checkedItems.length})',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...checkedItems.map((item) => _buildGroceryItem(item)),
                        ],
                      ],
                    ),
                  ),
                ),
        ),

        // Action buttons
        if (widget.groceryList.items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showClearDialog,
                    icon: const Icon(Icons.delete_sweep),
                    label: const Text('Clear List'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Remove all checked items
                      setState(() {
                        widget.groceryList.items.removeWhere((item) => item.isChecked);
                      });
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Remove Purchased'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Build individual grocery item tile
  Widget _buildGroceryItem(GroceryItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Checkbox(
            value: item.isChecked,
            onChanged: (value) {
              setState(() {
                widget.groceryList.toggleItem(item.id);
              });
            },
            activeColor: Colors.green,
          ),
          title: Text(
            item.name,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: item.isChecked ? TextDecoration.lineThrough : null,
              color: item.isChecked ? Colors.grey[500] : Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                widget.groceryList.removeItem(item.id);
              });
            },
            color: Colors.red[400],
          ),
        ),
      ),
    );
  }

  /// Show confirmation dialog before clearing list
  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear List?'),
        content: const Text('This will remove all items from your shopping list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.groceryList.clearAll();
              });
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              'Your shopping list is empty',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Add ingredients from recipes\nto start your shopping list!',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
