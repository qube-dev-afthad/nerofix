import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  const ShimmerWidget({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
      // baseColor: Colors.grey[300]!,
      // highlightColor: Colors.grey[100]!,
    );
  }

  static Widget textShimmer(double width, double height) {
    return ShimmerWidget(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  static Widget circle(double diameter) {
    return ShimmerWidget(
      child: Container(
        height: diameter,
        width: diameter,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
