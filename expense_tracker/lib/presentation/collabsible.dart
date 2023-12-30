import 'package:flutter/material.dart';

class Collapsible extends StatefulWidget {
  final String title;
  final Widget child;
  final List<bool> forceCollapse;

  const Collapsible(
      {super.key,
      required this.title,
      required this.child,
      required this.forceCollapse});

  @override
  State<Collapsible> createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  // bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      // _isExpanded = !_isExpanded;
      widget.forceCollapse[0] = !widget.forceCollapse[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Row(
            children: [
              Icon(widget.forceCollapse[0]
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right),
              Text(widget.title)
            ],
          ),
        ),
        if (widget.forceCollapse[0]) widget.child,
      ],
    );
  }
}
