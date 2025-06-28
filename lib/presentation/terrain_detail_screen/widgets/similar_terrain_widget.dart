import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SimilarTerrainWidget extends StatelessWidget {
  const SimilarTerrainWidget({super.key});

  // Mock similar terrain data
  final List<Map<String, dynamic>> similarTerrains = const [
    {
      "id": 2,
      "title": "Valley View Agricultural Land",
      "acreage": 38.2,
      "rentalRate": "\$2,500/season",
      "location": "Green Valley, CA",
      "distance": "2.3 miles away",
      "image":
          "https://images.pexels.com/photos/1595104/pexels-photo-1595104.jpeg",
      "rating": 4.6,
      "soilType": "Sandy Loam",
      "irrigationAvailable": true,
    },
    {
      "id": 3,
      "title": "Sunset Ridge Farm Land",
      "acreage": 52.8,
      "rentalRate": "\$3,200/season",
      "location": "Sunset Ridge, CA",
      "distance": "4.1 miles away",
      "image":
          "https://images.pexels.com/photos/2132180/pexels-photo-2132180.jpeg",
      "rating": 4.4,
      "soilType": "Clay Loam",
      "irrigationAvailable": false,
    },
    {
      "id": 4,
      "title": "Golden Fields Agricultural Plot",
      "acreage": 41.5,
      "rentalRate": "\$2,800/season",
      "location": "Golden Fields, CA",
      "distance": "3.7 miles away",
      "image":
          "https://images.pexels.com/photos/1595108/pexels-photo-1595108.jpeg",
      "rating": 4.7,
      "soilType": "Loamy Clay",
      "irrigationAvailable": true,
    },
  ];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Similar Terrain Nearby',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => _viewAllSimilarTerrain(context),
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 28.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: similarTerrains.length,
              separatorBuilder: (context, index) => SizedBox(width: 3.w),
              itemBuilder: (context, index) {
                final terrain = similarTerrains[index];
                return _buildTerrainCard(context, terrain);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerrainCard(BuildContext context, Map<String, dynamic> terrain) {
    return GestureDetector(
      onTap: () => _navigateToTerrainDetail(context, terrain),
      child: Container(
        width: 70.w,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.lightTheme.colorScheme.outline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: CustomImageWidget(
                imageUrl: terrain["image"] as String,
                width: 70.w,
                height: 15.h,
                fit: BoxFit.cover,
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            terrain["title"] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'star',
                              color: Colors.amber,
                              size: 3.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '${terrain["rating"]}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),

                    // Location and Distance
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'location_on',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 3.w,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            terrain["location"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 0.5.h),

                    Text(
                      terrain["distance"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Acreage and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${terrain["acreage"]} acres',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          terrain["rentalRate"] as String,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),

                    // Features
                    Row(
                      children: [
                        _buildFeatureTag(terrain["soilType"] as String),
                        SizedBox(width: 2.w),
                        if (terrain["irrigationAvailable"] == true)
                          _buildFeatureTag('Irrigation'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.lightTheme.colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _navigateToTerrainDetail(
      BuildContext context, Map<String, dynamic> terrain) {
    Navigator.pushNamed(context, '/terrain-detail-screen');
  }

  void _viewAllSimilarTerrain(BuildContext context) {
    Navigator.pushNamed(context, '/discover-screen');
  }
}
