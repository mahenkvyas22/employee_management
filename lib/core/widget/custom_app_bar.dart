import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: actions ?? [],
    );
  }

  // Define the preferred size for the CustomAppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
