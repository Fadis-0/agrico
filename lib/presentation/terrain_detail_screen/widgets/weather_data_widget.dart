import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WeatherDataWidget extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherDataWidget({
    super.key,
    required this.weatherData,
  });

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
            'Climate & Growing Conditions',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 2.h),

          // Weather Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            children: [
              _buildWeatherCard(
                icon: 'thermostat',
                title: 'Average Temperature',
                value: weatherData["averageTemp"] as String,
                color: Colors.orange,
              ),
              _buildWeatherCard(
                icon: 'water_drop',
                title: 'Annual Rainfall',
                value: weatherData["averageRainfall"] as String,
                color: Colors.blue,
              ),
              _buildWeatherCard(
                icon: 'wb_sunny',
                title: 'Growing Season',
                value: weatherData["growingSeason"] as String,
                color: Colors.green,
              ),
              _buildWeatherCard(
                icon: 'ac_unit',
                title: 'Frost Dates',
                value: weatherData["frostDates"] as String,
                color: Colors.lightBlue,
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Growing Season Timeline
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
                  'Growing Season Timeline',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                _buildTimelineItem(
                  month: 'March',
                  activity: 'Last Frost - Soil Preparation',
                  icon: 'ac_unit',
                ),
                _buildTimelineItem(
                  month: 'April',
                  activity: 'Planting Season Begins',
                  icon: 'eco',
                ),
                _buildTimelineItem(
                  month: 'May-Sep',
                  activity: 'Peak Growing Season',
                  icon: 'wb_sunny',
                ),
                _buildTimelineItem(
                  month: 'October',
                  activity: 'Harvest Season',
                  icon: 'agriculture',
                ),
                _buildTimelineItem(
                  month: 'November',
                  activity: 'First Frost - Season End',
                  icon: 'ac_unit',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard({
    required String icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: color,
              size: 5.w,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String month,
    required String activity,
    required String icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(1.5.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 4.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  activity,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
