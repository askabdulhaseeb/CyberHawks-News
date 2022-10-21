import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  const PrimaryButton(
      {Key? key, required this.text, this.padding, required this.onPressed})
      : super(key: key);
  Color getColor(Set<MaterialState> states, BuildContext context) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Theme.of(context).primaryColor.withOpacity(0.8);
    }
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text!,
        style: const TextStyle(fontSize: 16),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => getColor(states, context),
        ),
      ),
    );
  }
}
