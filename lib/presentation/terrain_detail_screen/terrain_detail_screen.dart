import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/availability_calendar_widget.dart';
import './widgets/farming_history_widget.dart';
import './widgets/inquiry_bottom_sheet_widget.dart';
import './widgets/landowner_profile_widget.dart';
import './widgets/reviews_section_widget.dart';
import './widgets/similar_terrain_widget.dart';
import './widgets/terrain_image_gallery_widget.dart';
import './widgets/terrain_info_card_widget.dart';
import './widgets/terrain_map_widget.dart';
import './widgets/terrain_specifications_widget.dart';
import './widgets/weather_data_widget.dart';

class TerrainDetailScreen extends StatefulWidget {
  const TerrainDetailScreen({super.key});

  @override
  State<TerrainDetailScreen> createState() => _TerrainDetailScreenState();
}

class _TerrainDetailScreenState extends State<TerrainDetailScreen> {
  bool isSaved = false;
  final ScrollController _scrollController = ScrollController();

  // Mock terrain data
  final Map<String, dynamic> terrainData = {
    "id": 1,
    "title": "Premium Agricultural Land - Riverside Valley",
    "acreage": 45.5,
    "rentalRatePerSeason": "\$2,800",
    "rentalRatePerYear": "\$8,500",
    "availabilityStatus": "Available",
    "location": "Riverside Valley, CA",
    "soilType": "Loamy Clay",
    "irrigationAvailable": true,
    "organicCertified": true,
    "accessRoads": "Paved road access",
    "storageAvailable": true,
    "previousCrops": ["Corn", "Soybeans", "Wheat"],
    "images": [
      "https://images.pexels.com/photos/2132227/pexels-photo-2132227.jpeg",
      "https://images.pexels.com/photos/1595104/pexels-photo-1595104.jpeg",
      "https://images.pexels.com/photos/1595108/pexels-photo-1595108.jpeg",
      "https://images.pexels.com/photos/2132180/pexels-photo-2132180.jpeg"
    ],
    "landowner": {
      "name": "Robert Johnson",
      "photo":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "rating": 4.8,
      "phone": "+1 (555) 123-4567",
      "email": "robert.johnson@email.com",
      "yearsExperience": 15
    },
    "weatherData": {
      "averageRainfall": "32 inches/year",
      "growingSeason": "April - October",
      "averageTemp": "68°F",
      "frostDates": "Last: March 15, First: November 10"
    },
    "farmingHistory": [
      {
        "year": 2023,
        "crop": "Corn",
        "yield": "180 bushels/acre",
        "notes": "Excellent growing season"
      },
      {
        "year": 2022,
        "crop": "Soybeans",
        "yield": "55 bushels/acre",
        "notes": "Good soil health maintained"
      }
    ],
    "reviews": [
      {
        "farmerName": "Mike Davis",
        "rating": 5,
        "comment":
            "Excellent land quality and very cooperative landowner. Highly recommended!",
        "date": "2023-11-15"
      },
      {
        "farmerName": "Sarah Wilson",
        "rating": 4,
        "comment": "Good soil conditions and reliable irrigation system.",
        "date": "2023-09-20"
      }
    ]
  };

  void _showInquiryBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InquiryBottomSheetWidget(
        terrainData: terrainData,
      ),
    );
  }

  void _toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  void _shareTerrain() {
    // Share functionality implementation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Terrain details shared successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar with Image Gallery
              SliverAppBar(
                expandedHeight: 35.h,
                pinned: true,
                backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                leading: Container(
                  margin: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'arrow_back',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: _toggleSave,
                      icon: CustomIconWidget(
                        iconName: isSaved ? 'bookmark' : 'bookmark_border',
                        color: isSaved
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurface,
                        size: 6.w,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4.w, top: 2.w, bottom: 2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: _shareTerrain,
                      icon: CustomIconWidget(
                        iconName: 'share',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 6.w,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: TerrainImageGalleryWidget(
                    images: (terrainData["images"] as List)
                        .map((img) => img as String)
                        .toList(),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Terrain Info Card
                    TerrainInfoCardWidget(terrainData: terrainData),

                    SizedBox(height: 2.h),

                    // Landowner Profile
                    LandownerProfileWidget(
                      landownerData:
                          terrainData["landowner"] as Map<String, dynamic>,
                    ),

                    SizedBox(height: 2.h),

                    // Terrain Specifications
                    TerrainSpecificationsWidget(terrainData: terrainData),

                    SizedBox(height: 2.h),

                    // Interactive Map
                    TerrainMapWidget(terrainData: terrainData),

                    SizedBox(height: 2.h),

                    // Availability Calendar
                    AvailabilityCalendarWidget(terrainData: terrainData),

                    SizedBox(height: 2.h),

                    // Weather Data
                    WeatherDataWidget(
                      weatherData:
                          terrainData["weatherData"] as Map<String, dynamic>,
                    ),

                    SizedBox(height: 2.h),

                    // Farming History
                    FarmingHistoryWidget(
                      farmingHistory: (terrainData["farmingHistory"] as List)
                          .map((item) => item as Map<String, dynamic>)
                          .toList(),
                    ),

                    SizedBox(height: 2.h),

                    // Reviews Section
                    ReviewsSectionWidget(
                      reviews: (terrainData["reviews"] as List)
                          .map((item) => item as Map<String, dynamic>)
                          .toList(),
                    ),

                    SizedBox(height: 2.h),

                    // Similar Terrain
                    SimilarTerrainWidget(),

                    SizedBox(height: 10.h), // Space for FAB
                  ],
                ),
              ),
            ],
          ),

          // Floating Action Button
          Positioned(
            bottom: 4.h,
            right: 4.w,
            child: FloatingActionButton.extended(
              onPressed: _showInquiryBottomSheet,
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
              label: Text(
                'Inquire About Land',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                ),
              ),
              icon: CustomIconWidget(
                iconName: 'contact_mail',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
