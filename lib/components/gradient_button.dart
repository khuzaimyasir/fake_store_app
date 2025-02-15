import 'dart:math';

import 'package:fake_store_app/components/gradient_border.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';


/// Buttonn with Gradient border
class GradientButton extends StatelessWidget {
  /// Buttonn with Gradient border
  const GradientButton({
    Key? key,
    required void Function() onPressed,
    required Widget child,
    double? strokeWidth,
    BoxDecoration? decoration,
  })  : _onPressed = onPressed,
        _child = child,
        _strokeWidth = strokeWidth ?? 1,
        _decoration = decoration,
        super(key: key);

  final void Function() _onPressed;
  final Widget _child;
  final double _strokeWidth;
  final BoxDecoration? _decoration;

  @override
  Widget build(BuildContext context) {
    return GradientBorder(
      strokeWidth: _strokeWidth,
      borderRadius: 4,
      gradient: redOrangeGradient,
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(max(4 - _strokeWidth, 0)),
        color: Colors.black87,
        child: Ink(
          decoration: _decoration,
          child: InkWell(
            onTap: _onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: _child,
            ),
          ),
        ),
      ),
    );
  }
}
//   check dbestech making components cubit tutorial