import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/emotion_model.dart';
import 'package:quit_smoking/presentation/emotional_diary/widgets/emotion_widget.dart';
import 'package:quit_smoking/presentation/emotional_diary/widgets/recent_notes_list.dart';
import 'package:quit_smoking/services/emotion_service.dart';

class EmotionalDiaryPage extends StatefulWidget {
  const EmotionalDiaryPage({super.key});

  @override
  State<EmotionalDiaryPage> createState() => _EmotionalDiaryPageState();
}

class _EmotionalDiaryPageState extends State<EmotionalDiaryPage> {
  List<EmotionModel> emotions = [];
  StreamSubscription? _emotionSub;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    _emotionSub = EmotionService.getUserEmotions().listen((event) {
      setState(() {
        emotions = event;
      });
    });
  }

  @override
  void dispose() {
    _emotionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsetsGeometry.fromLTRB(Gap.md, 0, Gap.md, Gap.lg),
              child: Column(
                spacing: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nhật kí cảm xúc', style: context.textTheme.titleSmall),
                  Text(
                    'Ghi lại cảm xúc và suy nghĩ',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: paddingApp,
              child: Column(
                children: [EmotionWidget(), RecentNotesList(emotions)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
