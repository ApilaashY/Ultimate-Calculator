// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

class SpacedListItem extends StatelessWidget {
  const SpacedListItem({super.key, required this.child, this.spacing = 20});

  final Widget child;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: spacing,
        ),
        child,
        SizedBox(
          height: spacing,
        )
      ],
    );
  }
}
