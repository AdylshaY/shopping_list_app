// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list_app/config.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    try {
      final result = await http.get(
        Uri.https(
          Config.flutterDbUrl,
          'shopping-list.json',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (result.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });
        return;
      }

      if (result.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(result.body);
      final List<GroceryItem> loadedItems = [];
      for (var item in listData.entries) {
        final category = categories.entries.firstWhere(
          (element) => element.value.title == item.value['category'],
        );
        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category.value,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
      });
    } catch (error) {
      setState(() {
        _error = 'Failed to fetch data. Please try again later.';
      });
    }
  }

  void _addItem() async {
    final addedData = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (addedData != null) {
      setState(() {
        _groceryItems.add(addedData);
        _isLoading = false;
      });
    }
  }

  void _removeItem(GroceryItem item) async {
    final itemIndex = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });

    var response = await http.delete(
      Uri.https(
        Config.flutterDbUrl,
        'shopping-list/${item.id}.json',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (!context.mounted) {
      return;
    }

    if (response.statusCode >= 400) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to remove item.'),
        ),
      );

      setState(() {
        _groceryItems.insert(itemIndex, item);
      });

      return;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items yet. Add some!'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) => _removeItem(_groceryItems[index]),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
      ),
      body: content,
    );
  }
}
