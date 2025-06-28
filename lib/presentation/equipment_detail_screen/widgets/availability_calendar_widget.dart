import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AvailabilityCalendarWidget extends StatefulWidget {
  const AvailabilityCalendarWidget({super.key});

  @override
  State<AvailabilityCalendarWidget> createState() =>
      _AvailabilityCalendarWidgetState();
}

class _AvailabilityCalendarWidgetState
    extends State<AvailabilityCalendarWidget> {
  DateTime _selectedMonth = DateTime.now();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  // Mock availability data
  final Map<DateTime, Map<String, dynamic>> _availabilityData = {
    DateTime(2024, 1, 15): {"available": false, "reason": "Booked"},
    DateTime(2024, 1, 16): {"available": false, "reason": "Booked"},
    DateTime(2024, 1, 20): {"available": false, "reason": "Maintenance"},
    DateTime(2024, 1, 25): {"available": true, "price": "\$280"},
    DateTime(2024, 1, 26): {"available": true, "price": "\$280"},
    DateTime(2024, 1, 27): {"available": true, "price": "\$320"},
    DateTime(2024, 1, 28): {"available": true, "price": "\$320"},
  };

  void _onDateSelected(DateTime date) {
    final availability =
        _availabilityData[DateTime(date.year, date.month, date.day)];
    if (availability != null && !(availability["available"] as bool)) {
      return; // Don't allow selection of unavailable dates
    }

    setState(() {
      if (_selectedStartDate == null || (_selectedEndDate != null)) {
        _selectedStartDate = date;
        _selectedEndDate = null;
      } else if (date.isBefore(_selectedStartDate!)) {
        _selectedStartDate = date;
        _selectedEndDate = null;
      } else {
        _selectedEndDate = date;
      }
    });
  }

  bool _isDateInRange(DateTime date) {
    if (_selectedStartDate == null) return false;
    if (_selectedEndDate == null) {
      return date.isAtSameMomentAs(_selectedStartDate!);
    }

    return date.isAfter(_selectedStartDate!.subtract(Duration(days: 1))) &&
        date.isBefore(_selectedEndDate!.add(Duration(days: 1)));
  }

  Color _getDateColor(DateTime date) {
    final availability =
        _availabilityData[DateTime(date.year, date.month, date.day)];

    if (_isDateInRange(date)) {
      return AppTheme.lightTheme.colorScheme.primary;
    }

    if (availability != null) {
      if (availability["available"] as bool) {
        return AppTheme.getSuccessColor(true);
      } else {
        return AppTheme.lightTheme.colorScheme.error;
      }
    }

    return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Availability Calendar',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedMonth = DateTime(
                            _selectedMonth.year, _selectedMonth.month - 1);
                      });
                    },
                    icon: CustomIconWidget(
                      iconName: 'chevron_left',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedMonth = DateTime(
                            _selectedMonth.year, _selectedMonth.month + 1);
                      });
                    },
                    icon: CustomIconWidget(
                      iconName: 'chevron_right',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Month/Year display
          Text(
            '${_getMonthName(_selectedMonth.month)} ${_selectedMonth.year}',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),

          // Calendar grid
          _buildCalendarGrid(),
          SizedBox(height: 3.h),

          // Legend
          _buildLegend(),

          // Selected dates info
          if (_selectedStartDate != null) _buildSelectedDatesInfo(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final lastDayOfMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return Column(
      children: [
        // Weekday headers
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 1.h),

        // Calendar days
        ...List.generate((daysInMonth + firstDayWeekday - 1) ~/ 7 + 1,
            (weekIndex) {
          return Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber =
                    weekIndex * 7 + dayIndex - firstDayWeekday + 2;
                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  return Expanded(child: SizedBox());
                }

                final date = DateTime(
                    _selectedMonth.year, _selectedMonth.month, dayNumber);
                final availability = _availabilityData[date];
                final isToday = _isToday(date);
                final isSelected = _isDateInRange(date);

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onDateSelected(date),
                    child: Container(
                      height: 10.w,
                      margin: EdgeInsets.all(0.5.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : availability != null &&
                                    !(availability["available"] as bool)
                                ? AppTheme.lightTheme.colorScheme.error
                                    .withValues(alpha: 0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isToday
                            ? Border.all(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          dayNumber.toString(),
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.onPrimary
                                : availability != null &&
                                        !(availability["available"] as bool)
                                    ? AppTheme.lightTheme.colorScheme.error
                                    : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight:
                                isToday ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legend',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            _buildLegendItem(
              color: AppTheme.getSuccessColor(true),
              label: 'Available',
            ),
            SizedBox(width: 4.w),
            _buildLegendItem(
              color: AppTheme.lightTheme.colorScheme.error,
              label: 'Unavailable',
            ),
            SizedBox(width: 4.w),
            _buildLegendItem(
              color: AppTheme.lightTheme.colorScheme.primary,
              label: 'Selected',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 3.w,
          height: 3.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildSelectedDatesInfo() {
    return Container(
      margin: EdgeInsets.only(top: 3.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Dates',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            _selectedEndDate != null
                ? '${_formatDate(_selectedStartDate!)} - ${_formatDate(_selectedEndDate!)}'
                : _formatDate(_selectedStartDate!),
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (_selectedEndDate != null) ...[
            SizedBox(height: 1.h),
            Text(
              '${_calculateDays()} days selected',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  bool _isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  int _calculateDays() {
    if (_selectedStartDate == null || _selectedEndDate == null) return 1;
    return _selectedEndDate!.difference(_selectedStartDate!).inDays + 1;
  }
}
