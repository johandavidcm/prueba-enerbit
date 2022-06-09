import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  const DefaultLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: child,
      ),
    );
  }
}
