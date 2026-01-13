import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarRed(String message) {
  _showGlobalToast(
    message: message,
    color: Colors.red,
    icon: Icons.warning,
  );
}

void showSnackBarGreen(String message) {
  _showGlobalToast(
    message: message,
    color: Colors.green,
    icon: Icons.check_circle,
  );
}

void _showGlobalToast({
  required String message,
  required Color color,
  required IconData icon,
}) {
  final overlay = Get.overlayContext;

  if (overlay == null) return;

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder:
        (_) => _ToastWidget(
      message: message,
      color: color,
      icon: icon,
      onClose: () => entry.remove(),
    ),
  );

  Overlay.of(overlay).insert(entry);
}
class _ToastWidget extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onClose;

  const _ToastWidget({
    required this.message,
    required this.color,
    required this.icon,
    required this.onClose,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slide = Tween(begin: const Offset(0, -0.4), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      await _controller.reverse();
      widget.onClose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black26),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
