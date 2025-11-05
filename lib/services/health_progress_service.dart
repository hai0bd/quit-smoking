class HealthProgressService {
  static Map<String, double> calculateHealthProgress(DateTime quitDate) {
    final now = DateTime.now();
    final days = now.difference(quitDate).inDays;

    double lung = _getProgress(
      days,
      [1, 3, 7, 30, 90, 180, 365, 730],
      [2, 5, 10, 25, 50, 70, 90, 100],
    );
    double heart = _getProgress(
      days,
      [1, 3, 7, 30, 90, 180, 365, 730],
      [3, 5, 15, 30, 60, 80, 95, 100],
    );
    double energy = _getProgress(
      days,
      [1, 3, 7, 30, 90, 180, 365, 730],
      [5, 10, 20, 35, 60, 80, 90, 100],
    );
    double sleep = _getProgress(
      days,
      [1, 3, 7, 30, 90, 180, 365, 730],
      [3, 5, 10, 20, 40, 60, 80, 100],
    );

    final avge = (lung + heart + energy + sleep) / 4;

    return {
      'lung': lung,
      'heart': heart,
      'energy': energy,
      'sleep': sleep,
      'avge': avge,
    };
  }

  static double _getProgress(int days, List<int> milestones, List<int> values) {
    for (int i = 0; i < milestones.length - 1; i++) {
      if (days <= milestones[i]) return values[i].toDouble();
      if (days < milestones[i + 1]) {
        final t = (days - milestones[i]) / (milestones[i + 1] - milestones[i]);
        return values[i] + t * (values[i + 1] - values[i]);
      }
    }
    return values.last.toDouble();
  }
}
