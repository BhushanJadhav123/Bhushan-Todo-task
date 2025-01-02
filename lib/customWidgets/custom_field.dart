import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.onCallBack,
    this.maxLines,
    required this.text,
    this.intitalText,
  });
  final String text;
  final String? intitalText;

  final Function(String) onCallBack;
  final int? maxLines;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.intitalText != null) {
      controller.text = widget.intitalText as String;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: controller,
      onChanged: (value) => widget.onCallBack(value),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
          isDense: true,
          hintMaxLines: 1,
          isCollapsed: true,
          filled: false,
          label: Text(widget.text,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.1),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
