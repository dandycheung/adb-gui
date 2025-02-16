import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final FloatingActionButton? floatingActionButton;
  final Widget child;

  const PageContainer({
    super.key,
    required this.title,
    this.floatingActionButton,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(thickness: 2.0),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
