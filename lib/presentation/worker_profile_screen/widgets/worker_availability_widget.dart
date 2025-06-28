import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WorkerAvailabilityWidget extends StatelessWidget {
  final Map<String, dynamic> availability;
  final bool isAvailable;

  const WorkerAvailabilityWidget({
    super.key,
    required this.availability,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    final blockedDates = (availability["blockedDates"] as List).cast<String>();
    final preferredHours = availability["preferredHours"] as String;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Availability Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'schedule',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Availability',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Current Status
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: isAvailable
                  ? AppTheme.getSuccessColor(true).withValues(alpha: 0.1)
                  : AppTheme.getWarningColor(true).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isAvailable
                    ? AppTheme.getSuccessColor(true).withValues(alpha: 0.3)
                    : AppTheme.getWarningColor(true).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAvailable
                        ? AppTheme.getSuccessColor(true)
                        : AppTheme.getWarningColor(true),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAvailable ? 'Available for Work' : 'Currently Busy',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isAvailable
                              ? AppTheme.getSuccessColor(true)
                              : AppTheme.getWarningColor(true),
                        ),
                      ),
                      Text(
                        isAvailable
                            ? 'Ready to accept new job requests'
                            : 'Will be available soon',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // Preferred Hours
          Row(
            children: [
              CustomIconWidget(
                iconName: 'access_time',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferred Working Hours',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    preferredHours,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Calendar Preview
          Text(
            'Upcoming Schedule',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 1.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                // Calendar Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'January 2024',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'chevron_left',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        CustomIconWidget(
                          iconName: 'chevron_right',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Calendar Grid (simplified)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 21, // 3 weeks
                  itemBuilder: (context, index) {
                    final day = index + 10; // Starting from 10th
                    final isBlocked = blockedDates
                        .contains('2024-01-${day.toString().padLeft(2, '0')}');

                    return Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: isBlocked
                            ? AppTheme.getWarningColor(true)
                                .withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: isBlocked
                            ? Border.all(
                                color: AppTheme.getWarningColor(true)
                                    .withValues(alpha: 0.5))
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: isBlocked
                                ? AppTheme.getWarningColor(true)
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight:
                                isBlocked ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // Legend
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppTheme.getWarningColor(true)
                            .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Unavailable',
                      style: AppTheme.lightTheme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
