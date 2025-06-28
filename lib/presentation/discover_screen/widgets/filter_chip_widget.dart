import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.w),
      child: Chip(
        label: Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
        ),
        backgroundColor:
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        deleteIcon: CustomIconWidget(
          iconName: 'close',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 16,
        ),
        onDeleted: onRemove,
        side: BorderSide(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
