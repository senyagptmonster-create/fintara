import 'package:flutter/material.dart';

class EnvelopeFoldPainter extends CustomPainter {
  final double fillRatio; // 0.0 to 1.0
  final Color envelopeColor;

  const EnvelopeFoldPainter({
    required this.fillRatio,
    required this.envelopeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16));
    canvas.drawRRect(rrect, bgPaint);

    // Envelope body fill based on ratio
    final fillHeight = size.height * fillRatio.clamp(0.0, 1.0);
    final fillRect = Rect.fromLTWH(0, size.height - fillHeight, size.width, fillHeight);
    final fillPaint = Paint()
      ..color = envelopeColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawRect(fillRect, fillPaint);
    canvas.restore();

    // Envelope border & flap lines
    final linePaint = Paint()
      ..color = envelopeColor.withValues(alpha: 0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, linePaint);

    // Top V flap lines
    final flapPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height * 0.45)
      ..lineTo(size.width, 0);
    canvas.drawPath(flapPath, linePaint);

    // Bottom diagonal folds
    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.42, size.height * 0.48)
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 0.58, size.height * 0.48);
    canvas.drawPath(bottomPath, linePaint);
  }

  @override
  bool shouldRepaint(covariant EnvelopeFoldPainter oldDelegate) {
    return oldDelegate.fillRatio != fillRatio || oldDelegate.envelopeColor != envelopeColor;
  }
}
