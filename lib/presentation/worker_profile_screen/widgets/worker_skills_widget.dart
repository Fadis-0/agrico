import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WorkerSkillsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> skills;
  final List<String> certifications;
  final Map<String, dynamic> verification;

  const WorkerSkillsWidget({
    super.key,
    required this.skills,
    required this.certifications,
    required this.verification,
  });

  Color _getSkillLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'expert':
        return AppTheme.getSuccessColor(true);
      case 'advanced':
        return AppTheme.lightTheme.primaryColor;
      case 'intermediate':
        return AppTheme.getWarningColor(true);
      default:
        return AppTheme.lightTheme.colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          // Skills Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'build',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Skills & Equipment',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Skills Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 1.h,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];
              final level = skill["level"] as String;
              final name = skill["name"] as String;

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: _getSkillLevelColor(level).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getSkillLevelColor(level).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getSkillLevelColor(level),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            level,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: _getSkillLevelColor(level),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 3.h),

          // Certifications
          Text(
            'Certifications',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 1.h),

          ...certifications.map((cert) {
            return Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'verified',
                    color: AppTheme.getSuccessColor(true),
                    size: 16,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      cert,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 2.h),

          // Verification Badges
          Row(
            children: [
              if (verification["backgroundCheck"] as bool)
                _buildVerificationBadge('Background Check', 'security'),
              SizedBox(width: 2.w),
              if (verification["insurance"] as bool)
                _buildVerificationBadge('Insured', 'shield'),
              SizedBox(width: 2.w),
              if (verification["certifications"] as bool)
                _buildVerificationBadge('Certified', 'verified'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationBadge(String label, String iconName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.getSuccessColor(true).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.getSuccessColor(true).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.getSuccessColor(true),
            size: 12,
          ),
          SizedBox(width: 1.w),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.getSuccessColor(true),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
