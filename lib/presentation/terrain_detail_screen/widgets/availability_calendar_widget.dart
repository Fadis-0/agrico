import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AvailabilityCalendarWidget extends StatefulWidget {
  final Map<String, dynamic> terrainData;

  const AvailabilityCalendarWidget({
    super.key,
    required this.terrainData,
  });

  @override
  State<AvailabilityCalendarWidget> createState() =>
      _AvailabilityCalendarWidgetState();
}

class _AvailabilityCalendarWidgetState
    extends State<AvailabilityCalendarWidget> {
  DateTime selectedDate = DateTime.now();

  // Mock availability data
  final Map<String, Map<String, dynamic>> availabilityData = {
    "2024-01": {"status": "available", "price": "\$2,800"},
    "2024-02": {"status": "available", "price": "\$2,800"},
    "2024-03": {"status": "available", "price": "\$3,200"},
    "2024-04": {"status": "booked", "price": "\$3,500"},
    "2024-05": {"status": "booked", "price": "\$3,500"},
    "2024-06": {"status": "available", "price": "\$3,800"},
    "2024-07": {"status": "available", "price": "\$3,800"},
    "2024-08": {"status": "available", "price": "\$3,500"},
    "2024-09": {"status": "booked", "price": "\$3,200"},
    "2024-10": {"status": "available", "price": "\$3,000"},
    "2024-11": {"status": "available", "price": "\$2,800"},
    "2024-12": {"status": "available", "price": "\$2,800"},
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Availability Calendar',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 2.h),

          // Legend
          Row(
            children: [
              _buildLegendItem(
                color: AppTheme.lightTheme.colorScheme.primary,
                label: 'Available',
              ),
              SizedBox(width: 4.w),
              _buildLegendItem(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                label: 'Booked',
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 1.h,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = index + 1;
              final monthKey = "2024-${month.toString().padLeft(2, '0')}";
              final monthData = availabilityData[monthKey];

              return _buildMonthCard(
                month: _getMonthName(month),
                status: monthData?["status"] ?? "available",
                price: monthData?["price"] ?? "\$2,800",
              );
            },
          ),

          SizedBox(height: 2.h),

          // Seasonal Pricing Info
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seasonal Pricing',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                _buildPricingRow('Spring (Mar-May)', '\$3,200 - \$3,500'),
                _buildPricingRow('Summer (Jun-Aug)', '\$3,500 - \$3,800'),
                _buildPricingRow('Fall (Sep-Nov)', '\$2,800 - \$3,200'),
                _buildPricingRow('Winter (Dec-Feb)', '\$2,800'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthCard({
    required String month,
    required String status,
    required String price,
  }) {
    final isAvailable = status == "available";
    final backgroundColor = isAvailable
        ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
        : AppTheme.lightTheme.colorScheme.onSurfaceVariant
            .withValues(alpha: 0.1);
    final borderColor = isAvailable
        ? AppTheme.lightTheme.colorScheme.primary
        : AppTheme.lightTheme.colorScheme.onSurfaceVariant;

    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: borderColor,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            isAvailable ? 'Available' : 'Booked',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: borderColor,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            price,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: borderColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String season, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            season,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            price,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
