import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DateSelectedCallback = void Function(DateTime date);

class WeekDateBar extends StatefulWidget {
  final DateSelectedCallback? onDateSelected;
  final bool weekStartsMonday;
  final DateTime? initialSelectedDate;

  const WeekDateBar({
    super.key,
    this.onDateSelected,
    this.weekStartsMonday = true,
    this.initialSelectedDate,
  });

  @override
  _WeekDateBarState createState() => _WeekDateBarState();
}

class _WeekDateBarState extends State<WeekDateBar> with WidgetsBindingObserver {
  late DateTime _today;
  late List<DateTime> _weekDates;
  DateTime? _selected;
  Timer? _midnightTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _today = DateTime.now();
    _selected = widget.initialSelectedDate ?? _today;
    _computeWeekDates();
    _scheduleMidnightUpdate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final now = DateTime.now();
      if (!_isSameDate(now, _today)) {
        setState(() {
          _today = now;
          _computeWeekDates();
          _scheduleMidnightUpdate();
        });
      }
    }
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _computeWeekDates() {
    final now = DateTime.now();

    final int weekday = now.weekday;
    int startOffset;
    if (widget.weekStartsMonday) {
      startOffset = weekday - DateTime.monday;
    } else {
      final int sundayBasedIndex = (weekday % 7);
      startOffset = sundayBasedIndex;
    }

    final DateTime startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: startOffset));
    final dates = List<DateTime>.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );
    _weekDates = dates;
  }

  void _scheduleMidnightUpdate() {
    _midnightTimer?.cancel();
    final now = DateTime.now();

    final DateTime nextMidnight = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));
    final Duration untilMidnight = nextMidnight.difference(now);

    _midnightTimer = Timer(
      untilMidnight + const Duration(milliseconds: 200),
      () {
        if (mounted) {
          setState(() {
            _today = DateTime.now();
            _computeWeekDates();
            _scheduleMidnightUpdate();
          });
        }
      },
    );
  }

  String _weekdayShort(DateTime dt) {
    return DateFormat.E().format(dt);
  }

  String _dayNumber(DateTime dt) {
    return DateFormat.d().format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _weekDates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = _weekDates[index];
          final bool isToday = _isSameDate(date, _today);
          final bool isSelected =
              _selected != null && _isSameDate(date, _selected!);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selected = date;
              });
              widget.onDateSelected?.call(date);
            },
            child: Container(
              width: 64,
              // padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isToday
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey.shade300,
                  width: isSelected ? 0 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekdayShort(date),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isToday
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 6),
                  CircleAvatar(
                    // radius: 16,
                    backgroundColor: isSelected
                        ? Colors.white.withOpacity(0.0)
                        : (isToday
                              ? Theme.of(
                                  context,
                                ).colorScheme.secondary.withOpacity(0.12)
                              : Colors.transparent),
                    child: Text(
                      _dayNumber(date),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? Colors.white
                            : (isToday
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
