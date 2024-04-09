import 'package:flutter/material.dart';

class ViewReviewsScreen extends StatelessWidget {
  const ViewReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Reviews'),
      ),
      body: ListView.builder(
        itemCount: 5, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Review Title $index'),
            subtitle: Text('Review Description $index'), 
            leading: CircleAvatar(
              child: Text('$index'), 
            ),
          );
        },
      ),
    );
  }
}
