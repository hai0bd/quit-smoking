class DateCounterService {
  static Map<String, int> getTimeSinceQuit(DateTime startDate) {
    final now = DateTime.now();
    final difference = now.difference(startDate);

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  static String getFormattedDuration(DateTime startDate) {
    final diff = getTimeSinceQuit(startDate);

    final d = diff['days']!;
    final h = diff['hours']!;
    final m = diff['minutes']!;

    if (d > 0) return '$d ngày $h giờ $m phút';
    if (h > 0) return '$h giờ $m phút';
    return '$m phút';
  }

  static DateTime fromTimestamp(dynamic timestamp) {
    if (timestamp is DateTime) return timestamp;
    if (timestamp is int) {
      // Nếu lưu millis
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (timestamp?.seconds != null) {
      // Nếu là Timestamp của Firestore
      return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    }
    throw ArgumentError('Không thể chuyển timestamp sang DateTime');
  }
}
