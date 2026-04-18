import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../../habits/domain/habit_models.dart';
import '../../habits/domain/habit_repository.dart';
import '../../profile/domain/profile_models.dart';
import '../../profile/domain/progress_repository.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    required this.goal,
    required this.routine,
    required this.templates,
    required this.selectedTemplateIds,
    required this.isLoading,
    required this.isSubmitting,
    required this.completed,
    this.errorMessage,
  });

  factory OnboardingState.initial() {
    return OnboardingState(
      goal: ProfileOptions.goals.first,
      routine: ProfileOptions.routines.first,
      templates: const [],
      selectedTemplateIds: const {},
      isLoading: true,
      isSubmitting: false,
      completed: false,
    );
  }

  final String goal;
  final String routine;
  final List<HabitTemplate> templates;
  final Set<String> selectedTemplateIds;
  final bool isLoading;
  final bool isSubmitting;
  final bool completed;
  final String? errorMessage;

  List<HabitTemplate> get selectedTemplates => templates
      .where((template) => selectedTemplateIds.contains(template.id))
      .toList();

  OnboardingState copyWith({
    String? goal,
    String? routine,
    List<HabitTemplate>? templates,
    Set<String>? selectedTemplateIds,
    bool? isLoading,
    bool? isSubmitting,
    bool? completed,
    String? errorMessage,
  }) {
    return OnboardingState(
      goal: goal ?? this.goal,
      routine: routine ?? this.routine,
      templates: templates ?? this.templates,
      selectedTemplateIds: selectedTemplateIds ?? this.selectedTemplateIds,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      completed: completed ?? this.completed,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        goal,
        routine,
        templates,
        selectedTemplateIds,
        isLoading,
        isSubmitting,
        completed,
        errorMessage,
      ];
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required RecommendationEngine recommendationEngine,
    required HabitRepository habitRepository,
    required ProgressRepository progressRepository,
  })  : _recommendationEngine = recommendationEngine,
        _habitRepository = habitRepository,
        _progressRepository = progressRepository,
        super(OnboardingState.initial());

  final RecommendationEngine _recommendationEngine;
  final HabitRepository _habitRepository;
  final ProgressRepository _progressRepository;

  void load() {
    _refreshTemplates();
  }

  void setGoal(String goal) {
    emit(state.copyWith(goal: goal, isLoading: false));
    _refreshTemplates();
  }

  void setRoutine(String routine) {
    emit(state.copyWith(routine: routine, isLoading: false));
    _refreshTemplates();
  }

  void toggleTemplate(String templateId) {
    final nextSelection = {...state.selectedTemplateIds};
    if (!nextSelection.add(templateId)) {
      nextSelection.remove(templateId);
    }
    emit(state.copyWith(selectedTemplateIds: nextSelection, errorMessage: null));
  }

  Future<void> submit(String rawName) async {
    final name = rawName.trim();
    if (name.isEmpty) {
      emit(state.copyWith(errorMessage: 'Добавь имя или ник, чтобы продолжить.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    await _progressRepository.saveProfile(
      UserProfileDraft(
        name: name,
        goal: state.goal,
        routine: state.routine,
      ),
    );
    await _habitRepository.addTemplates(state.selectedTemplates);
    emit(state.copyWith(isSubmitting: false, completed: true));
  }

  void _refreshTemplates() {
    final templates = _recommendationEngine.recommend(
      goal: state.goal,
      routine: state.routine,
    );
    final validIds = templates.map((template) => template.id).toSet();
    final selected = state.selectedTemplateIds
        .where(validIds.contains)
        .toSet();
    if (selected.isEmpty) {
      selected.addAll(templates.take(3).map((template) => template.id));
    }
    emit(
      state.copyWith(
        templates: templates,
        selectedTemplateIds: selected,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.completed != current.completed && current.completed,
      listener: (context, state) => context.go('/home'),
      builder: (context, state) {
        return Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F766E),
                  Color(0xFF14B8A6),
                  Color(0xFFF8FAFC),
                ],
                stops: [0, 0.35, 1],
              ),
            ),
            child: SafeArea(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final compact = constraints.maxHeight < 820;
                        final dense = constraints.maxHeight < 720;
                        final contentPadding = dense ? 16.0 : 20.0;
                        final sectionSpacing = dense ? 16.0 : 20.0;
                        final introText = compact
                            ? 'Быстрый старт: имя, цель, ритм дня и стартовый набор привычек.'
                            : 'Первая версия рассчитана на быстрый старт: имя, цель, ритм дня и стартовый набор привычек.';

                        return SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.fromLTRB(
                            contentPadding,
                            dense ? 8 : 12,
                            contentPadding,
                            dense ? 16 : 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Habit Quest',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white70,
                                    ),
                              ),
                              SizedBox(height: dense ? 8 : 10),
                              Text(
                                'Соберем твою оффлайн-систему продуктивных привычек',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: dense ? 24 : (compact ? 28 : 30),
                                    ),
                              ),
                              SizedBox(height: dense ? 8 : 10),
                              Text(
                                introText,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white.withValues(alpha: 0.9),
                                    ),
                              ),
                              SizedBox(height: sectionSpacing),
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.all(compact ? 16 : 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'О тебе',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Имя или ник',
                                          hintText: 'Например, Роман',
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Главная цель',
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          for (final goal in ProfileOptions.goals)
                                            _SelectionChip(
                                              label: goal,
                                              selected: goal == state.goal,
                                              onSelected: () => context
                                                  .read<OnboardingCubit>()
                                                  .setGoal(goal),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Ритм дня',
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          for (final routine in ProfileOptions.routines)
                                            _SelectionChip(
                                              label: routine,
                                              selected: routine == state.routine,
                                              onSelected: () => context
                                                  .read<OnboardingCubit>()
                                                  .setRoutine(routine),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: sectionSpacing),
                              if (state.templates.isEmpty)
                                const EmptyStateCard(
                                  title: 'Нет подходящих шаблонов',
                                  description: 'Попробуй другой фокус или ритм дня.',
                                )
                              else
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(compact ? 16 : 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Стартовый набор',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Выбери привычки, с которых начнешь. Рекомендации обновляются под цель и режим дня.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: const Color(0xFF475569),
                                              ),
                                        ),
                                        const SizedBox(height: 16),
                                        for (final template in state.templates)
                                          _TemplateTile(
                                            template: template,
                                            selected: state.selectedTemplateIds.contains(
                                              template.id,
                                            ),
                                            onTap: () => context
                                                .read<OnboardingCubit>()
                                                .toggleTemplate(template.id),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (state.errorMessage != null) ...[
                                const SizedBox(height: 16),
                                Text(
                                  state.errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                              SizedBox(height: sectionSpacing),
                              FilledButton.icon(
                                onPressed: state.isSubmitting
                                    ? null
                                    : () => context
                                        .read<OnboardingCubit>()
                                        .submit(_nameController.text),
                                icon: state.isSubmitting
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : const Icon(Icons.rocket_launch_rounded),
                                label: const Text('Запустить приложение'),
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 56),
                                  backgroundColor: const Color(0xFFF59E0B),
                                  foregroundColor: const Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _SelectionChip extends StatelessWidget {
  const _SelectionChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: true,
      checkmarkColor: const Color(0xFF0F172A),
      selectedColor: const Color(0xFFCCFBF1),
      backgroundColor: const Color(0xFFF8FAFC),
      side: BorderSide(
        color: selected ? const Color(0xFF14B8A6) : const Color(0xFFE2E8F0),
      ),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF0F172A) : const Color(0xFF334155),
        fontWeight: FontWeight.w600,
      ),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onSelected: (_) => onSelected(),
    );
  }
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.selected,
    required this.onTap,
  });

  final HabitTemplate template;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selected ? const Color(0xFFECFEFF) : const Color(0xFFF8FAFC),
            border: Border.all(
              color: selected ? const Color(0xFF14B8A6) : const Color(0xFFE2E8F0),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: selected,
                onChanged: (_) => onTap(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF475569),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${template.schedule.weekdayLabel} • ${template.schedule.reminderLabel}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF0F766E),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
