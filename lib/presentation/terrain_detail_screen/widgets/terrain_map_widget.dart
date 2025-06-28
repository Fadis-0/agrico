import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TerrainMapWidget extends StatefulWidget {
  final Map<String, dynamic> terrainData;

  const TerrainMapWidget({
    super.key,
    required this.terrainData,
  });

  @override
  State<TerrainMapWidget> createState() => _TerrainMapWidgetState();
}

class _TerrainMapWidgetState extends State<TerrainMapWidget> {
  bool isSatelliteView = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
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
          // Header with toggle
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Location & Boundaries',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildViewToggle('Map', !isSatelliteView),
                      _buildViewToggle('Satellite', isSatelliteView),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Map Container
          Container(
            height: 25.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  // Mock Map Background
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color:
                        isSatelliteView ? Color(0xFF4A5D23) : Color(0xFFF5F5F5),
                    child: CustomPaint(
                      painter: _MapPainter(isSatelliteView: isSatelliteView),
                    ),
                  ),

                  // Map Controls
                  Positioned(
                    top: 2.h,
                    right: 2.w,
                    child: Column(
                      children: [
                        _buildMapControl(
                          icon: 'add',
                          onTap: () {},
                        ),
                        SizedBox(height: 1.h),
                        _buildMapControl(
                          icon: 'remove',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // Location Marker
                  Positioned(
                    top: 10.h,
                    left: 40.w,
                    child: CustomIconWidget(
                      iconName: 'location_on',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 8.w,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Map Features
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildMapFeature(
                    icon: 'water_drop',
                    label: 'Water Sources',
                    count: '3',
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: _buildMapFeature(
                    icon: 'business',
                    label: 'Infrastructure',
                    count: '2',
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: _buildMapFeature(
                    icon: 'straighten',
                    label: 'Boundaries',
                    count: 'Marked',
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // View Full Map Button
          Padding(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showFullMap(context),
                icon: CustomIconWidget(
                  iconName: 'map',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
                label: Text('View Full Map'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSatelliteView = label == 'Satellite';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? AppTheme.lightTheme.colorScheme.onPrimary
                : AppTheme.lightTheme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMapControl({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: CustomIconWidget(
          iconName: icon,
          color: AppTheme.lightTheme.colorScheme.onSurface,
          size: 4.w,
        ),
      ),
    );
  }

  Widget _buildMapFeature({
    required String icon,
    required String label,
    required String count,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          count,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showFullMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullMapScreen(terrainData: widget.terrainData),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  final bool isSatelliteView;

  _MapPainter({required this.isSatelliteView});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    if (isSatelliteView) {
      // Draw satellite view elements
      paint.color = Color(0xFF2D5016);
      canvas.drawRect(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.3, size.width * 0.6,
            size.height * 0.4),
        paint,
      );

      // Water sources
      paint.color = Color(0xFF1976D2);
      canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.2), 8, paint);
      canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.8), 6, paint);
    } else {
      // Draw map view elements
      paint.color = Color(0xFFE0E0E0);
      paint.strokeWidth = 2;
      paint.style = PaintingStyle.stroke;

      // Terrain boundary
      canvas.drawRect(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.3, size.width * 0.6,
            size.height * 0.4),
        paint,
      );

      // Roads
      paint.color = Color(0xFF9E9E9E);
      paint.style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.5, size.width, 4),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _FullMapScreen extends StatelessWidget {
  final Map<String, dynamic> terrainData;

  const _FullMapScreen({
    required this.terrainData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terrain Location'),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF5F5F5),
        child: Center(
          child: Text(
            'Interactive Map View\n${terrainData["location"]}',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
