import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserTypeSelectionWidget extends StatelessWidget {
  final String selectedUserType;
  final Function(String) onUserTypeChanged;

  const UserTypeSelectionWidget({
    super.key,
    required this.selectedUserType,
    required this.onUserTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUserTypeCard(
          context: context,
          userType: 'Farmer',
          title: 'Farmer',
          description:
              'I need equipment, land, or workers for my farming operations',
          iconName: 'agriculture',
          isSelected: selectedUserType == 'Farmer',
        ),
        SizedBox(height: 3.h),
        _buildUserTypeCard(
          context: context,
          userType: 'Worker',
          title: 'Worker',
          description: 'I operate equipment or provide agricultural services',
          iconName: 'engineering',
          isSelected: selectedUserType == 'Worker',
        ),
      ],
    );
  }

  Widget _buildUserTypeCard({
    required BuildContext context,
    required String userType,
    required String title,
    required String description,
    required String iconName,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onUserTypeChanged(userType),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.onPrimary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
