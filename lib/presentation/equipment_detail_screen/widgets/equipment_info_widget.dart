import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EquipmentInfoWidget extends StatelessWidget {
  final Map<String, dynamic> equipmentData;

  const EquipmentInfoWidget({
    super.key,
    required this.equipmentData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      color: AppTheme.lightTheme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Equipment title
          Text(
            equipmentData["title"] ?? "Equipment",
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Rating and reviews
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  final rating = equipmentData["rating"] as double? ?? 0.0;
                  return CustomIconWidget(
                    iconName: index < rating.floor() ? 'star' : 'star_border',
                    color: AppTheme.getAccentColor(true),
                    size: 4.w,
                  );
                }),
              ),
              SizedBox(width: 2.w),
              Text(
                '${equipmentData["rating"] ?? 0.0}',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 1.w),
              Text(
                '(${equipmentData["reviewCount"] ?? 0} reviews)',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),

          // Pricing and availability
          Row(
            children: [
              Expanded(
                child: _buildPriceCard(
                  title: 'Hourly Rate',
                  price: equipmentData["hourlyRate"] ?? "\$0.00",
                  subtitle: 'per hour',
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildPriceCard(
                  title: 'Daily Rate',
                  price: equipmentData["dailyRate"] ?? "\$0.00",
                  subtitle: 'per day',
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),

          // Availability status
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.getSuccessColor(true).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.getSuccessColor(true).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 3.w,
                  height: 3.w,
                  decoration: BoxDecoration(
                    color: AppTheme.getSuccessColor(true),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  equipmentData["availability"] ?? "Status Unknown",
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.getSuccessColor(true),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.getSuccessColor(true),
                  size: 5.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard({
    required String title,
    required String price,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            price,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
