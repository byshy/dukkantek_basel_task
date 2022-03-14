import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget child;
  final Color? color;
  final double radius;
  final List<Color>? colors;
  final List<BoxShadow>? shadow;
  final Alignment? begin;
  final Alignment? end;
  final BoxBorder? border;

  const CustomRaisedButton({
    Key? key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.color,
    this.colors,
    this.shadow,
    this.begin,
    this.end,
    this.border,
    this.radius = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 48,
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: child),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: onTap == null ? Colors.grey : color ?? Theme.of(context).primaryColor,
        border: border,
        borderRadius: BorderRadius.circular(radius),
        gradient: colors == null || onTap == null
            ? null
            : LinearGradient(
                begin: begin ?? Alignment.topCenter,
                end: end ?? Alignment.bottomCenter,
                colors: colors ?? [],
              ),
        boxShadow: shadow,
      ),
    );
  }
}
