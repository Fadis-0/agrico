import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EquipmentSpecificationsWidget extends StatefulWidget {
  final Map<String, dynamic> specifications;
  final String description;
  final String location;
  final List<String> safetyFeatures;
  final String insurance;

  const EquipmentSpecificationsWidget({
    super.key,
    required this.specifications,
    required this.description,
    required this.location,
    required this.safetyFeatures,
    required this.insurance,
  });

  @override
  State<EquipmentSpecificationsWidget> createState() =>
      _EquipmentSpecificationsWidgetState();
}

class _EquipmentSpecificationsWidgetState
    extends State<EquipmentSpecificationsWidget> {
  bool _showAllSpecs = false;
  bool _showSafetyDetails = false;
  bool _showInsuranceDetails = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description section
          _buildSection(
            title: 'Description',
            child: Text(
              widget.description,
              style: AppTheme.lightTheme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 3.h),

          // Location section
          _buildSection(
            title: 'Location',
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    widget.location,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),

          // Specifications section
          _buildSection(
            title: 'Specifications',
            child: Column(
              children: [
                ...widget.specifications.entries
                    .take(_showAllSpecs ? widget.specifications.length : 4)
                    .map(
                      (entry) => _buildSpecificationRow(
                          entry.key, entry.value.toString()),
                    ),
                if (widget.specifications.length > 4)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllSpecs = !_showAllSpecs;
                      });
                    },
                    child: Text(
                      _showAllSpecs ? 'Show Less' : 'Show All Specifications',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 3.h),

          // Safety Features section
          _buildSection(
            title: 'Safety Features',
            child: Column(
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'security',
                      color: AppTheme.getSuccessColor(true),
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${widget.safetyFeatures.length} safety features included',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.getSuccessColor(true),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (_showSafetyDetails) ...[
                  SizedBox(height: 2.h),
                  ...widget.safetyFeatures.map(
                    (feature) => Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.getSuccessColor(true),
                            size: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showSafetyDetails = !_showSafetyDetails;
                    });
                  },
                  child: Text(
                    _showSafetyDetails ? 'Hide Details' : 'View Details',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),

          // Insurance section
          _buildSection(
            title: 'Insurance Coverage',
            child: Column(
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'verified_user',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Fully Insured',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (_showInsuranceDetails) ...[
                  SizedBox(height: 2.h),
                  Text(
                    widget.insurance,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showInsuranceDetails = !_showInsuranceDetails;
                    });
                  },
                  child: Text(
                    _showInsuranceDetails ? 'Hide Details' : 'View Details',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Container(
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
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          child,
        ],
      ),
    );
  }

  Widget _buildSpecificationRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
