import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TerrainSpecificationsWidget extends StatelessWidget {
  final Map<String, dynamic> terrainData;

  const TerrainSpecificationsWidget({
    super.key,
    required this.terrainData,
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
            'Land Specifications',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 2.h),

          // Soil Type
          _buildSpecificationRow(
            icon: 'terrain',
            label: 'Soil Type',
            value: terrainData["soilType"] as String,
          ),

          SizedBox(height: 1.5.h),

          // Irrigation
          _buildSpecificationRow(
            icon: 'water_drop',
            label: 'Irrigation',
            value: terrainData["irrigationAvailable"] == true
                ? 'Available'
                : 'Not Available',
            isPositive: terrainData["irrigationAvailable"] == true,
          ),

          SizedBox(height: 1.5.h),

          // Access Roads
          _buildSpecificationRow(
            icon: 'road',
            label: 'Access Roads',
            value: terrainData["accessRoads"] as String,
          ),

          SizedBox(height: 1.5.h),

          // Storage Facilities
          _buildSpecificationRow(
            icon: 'warehouse',
            label: 'Storage Facilities',
            value: terrainData["storageAvailable"] == true
                ? 'Available'
                : 'Not Available',
            isPositive: terrainData["storageAvailable"] == true,
          ),

          SizedBox(height: 1.5.h),

          // Organic Certification
          _buildSpecificationRow(
            icon: 'eco',
            label: 'Organic Certified',
            value: terrainData["organicCertified"] == true ? 'Yes' : 'No',
            isPositive: terrainData["organicCertified"] == true,
          ),

          SizedBox(height: 2.h),

          // Previous Crops
          Text(
            'Previous Crops',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 1.h),

          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: (terrainData["previousCrops"] as List)
                .map((crop) => _buildCropChip(crop as String))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationRow({
    required String icon,
    required String label,
    required String value,
    bool? isPositive,
  }) {
    Color valueColor = AppTheme.lightTheme.colorScheme.onSurface;
    if (isPositive != null) {
      valueColor = isPositive
          ? AppTheme.lightTheme.colorScheme.primary
          : AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 5.w,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                value,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCropChip(String crop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        crop,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.lightTheme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
