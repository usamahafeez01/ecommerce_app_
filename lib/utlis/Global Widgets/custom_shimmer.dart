import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CustomShimmerEffect extends StatelessWidget {
  final Widget child;
  const CustomShimmerEffect({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: child);
  }
}
