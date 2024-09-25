import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> items = List.generate(10, (index) => index);
  bool isLoading = false;

  void _loadMore() async {
    if (isLoading) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      items.addAll(List.generate(1, (index) => items.length + index));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "scroll list view",
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: items.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == items.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListTile(
              title: Text('hello kunal  ${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
