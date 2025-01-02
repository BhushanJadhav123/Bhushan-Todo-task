import 'package:flutter/material.dart';

class _Button extends StatelessWidget {
  const _Button(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.title,
      this.buttonWidth,
      this.fontSize,
      this.buttonHeight});
  final Function() onPressed;
  final String title;
  final Color color;
  final double? buttonWidth;
  final double? fontSize;
  final double? buttonHeight;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(buttonWidth ?? 10, buttonHeight ?? 30)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20)),
          backgroundColor: MaterialStateProperty.all<Color>(color)),
      child: Text(title,
          style: TextStyle(
              fontSize: fontSize ?? 16,
              color: Colors.black,
              fontWeight: FontWeight.w500)),
    );
  }
}

/// Delete Button widget.
class DeleteButtoWidget extends StatelessWidget {
  const DeleteButtoWidget({super.key, required this.deleteOnPress});
  final Function() deleteOnPress;

  @override
  Widget build(BuildContext context) {
    return _Button(
      color: Colors.red,
      onPressed: deleteOnPress,
      title: "Delete",
    );
  }
}

/// Save Button for saving todo.
class SaveButtoWidget extends StatelessWidget {
  const SaveButtoWidget(
      {super.key,
      required this.onPress,
      this.isLoading = false,
      this.buttonText = "Save"});
  final Function() onPress;
  final bool isLoading;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : _Button(
            color: Colors.purple,
            fontSize: 20,
            buttonWidth: MediaQuery.of(context).size.width * 0.7,
            onPressed: onPress,
            title: buttonText,
            buttonHeight: 40,
          );
  }
}
