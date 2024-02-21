import 'package:daily_news_app/features/news_list/domain/news_list_entity.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key, required this.onClick});
  final Function(int index) onClick;

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(vsync: this, length: NewsCategory.values.length);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
          onTap: (value) => widget.onClick(value),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: _controller,
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          tabs: NewsCategory.values
              .map(
                (category) => Tab(text: category.name.toUpperCase()),
              )
              .toList()),
    );
  }
}
