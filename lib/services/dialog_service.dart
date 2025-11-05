import 'package:flutter/material.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/common/extensions.dart';

class DialogService {
  /// Giữ nguyên API cũ
  static Future<void> showError(
    BuildContext context,
    String title,
    String message,
  ) {
    return _showDialog(
      context,
      title,
      message,
      Colors.redAccent,
      Icons.error_outline,
    );
  }

  static Future<void> showSuccess(
    BuildContext context,
    String title,
    String message,
  ) {
    return _showDialog(
      context,
      title,
      message,
      Colors.green,
      Icons.check_circle_outline,
    );
  }

  /// Hàm hiển thị dialog chung
  static Future<void> _showDialog(
    BuildContext context,
    String title,
    String message,
    Color color,
    IconData icon,
  ) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: context.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Đóng',
              style: context.textTheme.bodyMedium?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
