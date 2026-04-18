import 'package:flutter/material.dart';

import '../domain/recovery_models.dart';

Future<DailyCheckInDraft?> showDailyCheckInSheet(BuildContext context) {
  return showModalBottomSheet<DailyCheckInDraft>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _DailyCheckInSheet(),
  );
}

class _DailyCheckInSheet extends StatefulWidget {
  const _DailyCheckInSheet();

  @override
  State<_DailyCheckInSheet> createState() => _DailyCheckInSheetState();
}

class _DailyCheckInSheetState extends State<_DailyCheckInSheet> {
  var _energy = RecoveryLevel.medium;
  var _load = RecoveryLevel.medium;
  var _mood = RecoveryLevel.medium;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Утренний check-in',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Коротко оцени состояние на сегодня, чтобы приложение могло адаптировать ритм.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF475569),
                    ),
              ),
              const SizedBox(height: 20),
              _LevelSelector(
                title: 'Энергия',
                value: _energy,
                lowLabel: 'Низкая',
                mediumLabel: 'Средняя',
                highLabel: 'Высокая',
                onChanged: (value) => setState(() => _energy = value),
              ),
              const SizedBox(height: 16),
              _LevelSelector(
                title: 'Нагрузка',
                value: _load,
                lowLabel: 'Легкий день',
                mediumLabel: 'Плотно',
                highLabel: 'Перегруз',
                onChanged: (value) => setState(() => _load = value),
              ),
              const SizedBox(height: 16),
              _LevelSelector(
                title: 'Настроение',
                value: _mood,
                lowLabel: 'Тяжело',
                mediumLabel: 'Нормально',
                highLabel: 'Хорошо',
                onChanged: (value) => setState(() => _mood = value),
              ),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(
                  DailyCheckInDraft(
                    energy: _energy,
                    load: _load,
                    mood: _mood,
                  ),
                ),
                icon: const Icon(Icons.wb_sunny_outlined),
                label: const Text('Сохранить check-in'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelSelector extends StatelessWidget {
  const _LevelSelector({
    required this.title,
    required this.value,
    required this.lowLabel,
    required this.mediumLabel,
    required this.highLabel,
    required this.onChanged,
  });

  final String title;
  final RecoveryLevel value;
  final String lowLabel;
  final String mediumLabel;
  final String highLabel;
  final ValueChanged<RecoveryLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        SegmentedButton<RecoveryLevel>(
          segments: [
            ButtonSegment(
              value: RecoveryLevel.low,
              label: Text(lowLabel),
            ),
            ButtonSegment(
              value: RecoveryLevel.medium,
              label: Text(mediumLabel),
            ),
            ButtonSegment(
              value: RecoveryLevel.high,
              label: Text(highLabel),
            ),
          ],
          selected: {value},
          onSelectionChanged: (selection) => onChanged(selection.first),
        ),
      ],
    );
  }
}
