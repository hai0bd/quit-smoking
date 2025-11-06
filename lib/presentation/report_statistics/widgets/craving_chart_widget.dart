import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/craving_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:quit_smoking/services/sos_service.dart';

class CravingChartWidget extends StatefulWidget {
  const CravingChartWidget({super.key});

  @override
  State<CravingChartWidget> createState() => _CravingChartWidgetState();
}

class _CravingChartWidgetState extends State<CravingChartWidget> {
  late Future<List<CravingData>> _chartDataFuture;
  DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _chartDataFuture = _loadCravingData();
  }

  Future<List<CravingData>> _loadCravingData() async {
    final history = await SOSService.getCravingHistory();
    final now = DateTime.now();

    final startDate =
        _selectedRange?.start ?? now.subtract(const Duration(days: 6));
    final endDate = _selectedRange?.end ?? now;

    final Map<String, int> dayCount = {};
    for (final date in history) {
      if (date.isAfter(startDate.subtract(const Duration(days: 1))) &&
          date.isBefore(endDate.add(const Duration(days: 1)))) {
        final key = DateFormat('dd/MM').format(date);
        dayCount[key] = (dayCount[key] ?? 0) + 1;
      }
    }

    final List<CravingData> data = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      final day = startDate.add(Duration(days: i));
      final label = DateFormat('dd/MM').format(day);
      data.add(CravingData(day: label, count: dayCount[label] ?? 0));
    }

    return data;
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
      initialDateRange:
          _selectedRange ??
          DateTimeRange(start: now.subtract(const Duration(days: 6)), end: now),
    );

    if (picked != null) {
      setState(() {
        _selectedRange = picked;
        _chartDataFuture = _loadCravingData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CravingData>>(
      future: _chartDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data ?? [];

        return Container(
          padding: EdgeInsets.all(Gap.md),
          decoration: BoxDecoration(
            borderRadius: radius12,
            border: Border.all(width: 1, color: borderColor),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Cơn thèm thuốc', style: context.textTheme.titleSmall),
                  const Spacer(),
                  IconButton(
                    onPressed: _pickDateRange,
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
              if (_selectedRange != null)
                Text(
                  '${DateFormat('dd/MM').format(_selectedRange!.start)} - ${DateFormat('dd/MM').format(_selectedRange!.end)}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
              Gap.smHeight,
              if (data.isEmpty)
                Text(
                  'Chưa có dữ liệu trong khoảng thời gian này.',
                  style: context.textTheme.titleSmall,
                )
              else
                AspectRatio(
                  aspectRatio: 1.3,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      labelStyle: const TextStyle(fontSize: 11),
                    ),

                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      interval: 1,
                      labelStyle: const TextStyle(fontSize: 11),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: [
                      ColumnSeries<CravingData, String>(
                        dataSource: data,
                        xValueMapper: (d, _) => d.day,
                        yValueMapper: (d, _) => d.count,
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
