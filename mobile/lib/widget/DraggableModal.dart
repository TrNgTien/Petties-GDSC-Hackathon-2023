import 'package:flutter/material.dart';

class DraggableSheet extends StatefulWidget {
  final Widget child;

  DraggableSheet({required this.child});

  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double _dragOffset = 0.0;
  double _maxDragOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta!;
      if (_dragOffset > _maxDragOffset) {
        _dragOffset = _maxDragOffset;
      } else if (_dragOffset < 0.0) {
        _dragOffset = 0.0;
      }
      _controller.value = _dragOffset / _maxDragOffset;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset >= _maxDragOffset * 0.5) {
      _controller.forward();
    } else {
      _dragOffset = 0.0;
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    _maxDragOffset = MediaQuery.of(context).size.height / 2;
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: SlideTransition(
        position: _animation,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2 + _dragOffset / 2,
          child: widget.child,
        ),
      ),
    );
  }
}
