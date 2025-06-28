import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/availability_calendar_widget.dart';
import './widgets/booking_bottom_sheet_widget.dart';
import './widgets/equipment_image_carousel_widget.dart';
import './widgets/equipment_info_widget.dart';
import './widgets/equipment_specifications_widget.dart';
import './widgets/owner_profile_card_widget.dart';
import './widgets/reviews_section_widget.dart';
import './widgets/similar_equipment_widget.dart';

class EquipmentDetailScreen extends StatefulWidget {
  const EquipmentDetailScreen({super.key});

  @override
  State<EquipmentDetailScreen> createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = true;

  // Mock equipment data
  final Map<String, dynamic> equipmentData = {
    "id": 1,
    "title": "John Deere 5075E Tractor",
    "hourlyRate": "\$45.00",
    "dailyRate": "\$320.00",
    "availability": "Available",
    "rating": 4.8,
    "reviewCount": 127,
    "images": [
      "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg",
      "https://images.pexels.com/photos/1595108/pexels-photo-1595108.jpeg",
      "https://images.pexels.com/photos/2132251/pexels-photo-2132251.jpeg",
    ],
    "owner": {
      "name": "Michael Rodriguez",
      "avatar":
          "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg",
      "rating": 4.9,
      "totalEquipment": 12,
      "yearsExperience": 8,
    },
    "specifications": {
      "Horsepower": "75 HP",
      "Engine Type": "4-Cylinder Diesel",
      "Transmission": "12F/12R PowrReverser",
      "Fuel Capacity": "26.4 gallons",
      "Weight": "7,716 lbs",
      "Attachment Compatibility": "Category 1 & 2",
      "Maintenance Status": "Recently Serviced",
      "Year": "2019",
    },
    "description":
        "Well-maintained John Deere 5075E tractor perfect for medium-scale farming operations. Features comfortable cab with air conditioning, power steering, and excellent visibility. Ideal for plowing, cultivating, and general farm work. Regular maintenance performed, all safety features functional.",
    "location": "Springfield Valley Farm, 15 miles from city center",
    "safetyFeatures": [
      "ROPS (Roll-Over Protective Structure)",
      "Seat belt and safety switches",
      "Emergency stop button",
      "LED work lights",
      "Backup alarm"
    ],
    "insurance":
        "Fully insured with comprehensive coverage including operator liability",
  };

  final List<Map<String, dynamic>> reviewsData = [
    {
      "id": 1,
      "userName": "Sarah Johnson",
      "userAvatar":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg",
      "rating": 5.0,
      "date": "2 weeks ago",
      "comment":
          "Excellent tractor! Very reliable and well-maintained. Michael was helpful with pickup instructions.",
      "images": [
        "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg",
      ],
    },
    {
      "id": 2,
      "userName": "David Chen",
      "userAvatar":
          "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg",
      "rating": 4.5,
      "date": "1 month ago",
      "comment":
          "Great equipment for the price. Helped me complete my harvest on time. Would rent again.",
      "images": [],
    },
    {
      "id": 3,
      "userName": "Maria Garcia",
      "userAvatar":
          "https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg",
      "rating": 5.0,
      "date": "2 months ago",
      "comment":
          "Perfect for my 50-acre farm. Easy to operate and fuel efficient. Highly recommended!",
      "images": [],
    },
  ];

  final List<Map<String, dynamic>> similarEquipmentData = [
    {
      "id": 2,
      "title": "Kubota M7060",
      "hourlyRate": "\$42.00",
      "dailyRate": "\$295.00",
      "image":
          "https://images.pexels.com/photos/1595108/pexels-photo-1595108.jpeg",
      "rating": 4.7,
      "distance": "8.2 miles",
      "horsepower": "70 HP",
    },
    {
      "id": 3,
      "title": "New Holland T4.75",
      "hourlyRate": "\$40.00",
      "dailyRate": "\$280.00",
      "image":
          "https://images.pexels.com/photos/2132251/pexels-photo-2132251.jpeg",
      "rating": 4.6,
      "distance": "12.5 miles",
      "horsepower": "74 HP",
    },
    {
      "id": 4,
      "title": "Massey Ferguson 4707",
      "hourlyRate": "\$48.00",
      "dailyRate": "\$340.00",
      "image":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg",
      "rating": 4.8,
      "distance": "15.3 miles",
      "horsepower": "75 HP",
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && _showFloatingButton) {
      setState(() {
        _showFloatingButton = false;
      });
    } else if (_scrollController.offset <= 100 && !_showFloatingButton) {
      setState(() {
        _showFloatingButton = true;
      });
    }
  }

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookingBottomSheetWidget(
        equipmentData: equipmentData,
      ),
    );
  }

  void _shareEquipment() {
    // Share functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality would be implemented here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavorite() {
    // Favorite functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _contactOwner() {
    // Contact owner functionality
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Contact ${equipmentData["owner"]["name"]}',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 3.h),
            _buildContactOption(
              icon: 'message',
              title: 'Send Message',
              subtitle: 'Chat in-app',
              onTap: () => Navigator.pop(context),
            ),
            _buildContactOption(
              icon: 'phone',
              title: 'Call',
              subtitle: 'Direct phone call',
              onTap: () => Navigator.pop(context),
            ),
            _buildContactOption(
              icon: 'chat',
              title: 'WhatsApp',
              subtitle: 'Message on WhatsApp',
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        margin: EdgeInsets.only(bottom: 1.h),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'arrow_forward_ios',
              color: AppTheme.lightTheme.colorScheme.outline,
              size: 4.w,
            ),
          ],
        ),
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
              // Custom App Bar
              SliverAppBar(
                expandedHeight: 35.h,
                pinned: true,
                backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                leading: Container(
                  margin: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: CustomIconWidget(
                      iconName: 'arrow_back',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: CustomIconWidget(
                        iconName: 'share',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 5.w,
                      ),
                      onPressed: _shareEquipment,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: CustomIconWidget(
                        iconName: 'favorite_border',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 5.w,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: EquipmentImageCarouselWidget(
                    images: (equipmentData["images"] as List).cast<String>(),
                  ),
                ),
              ),

              // Equipment Info
              SliverToBoxAdapter(
                child: EquipmentInfoWidget(
                  equipmentData: equipmentData,
                ),
              ),

              // Owner Profile Card
              SliverToBoxAdapter(
                child: OwnerProfileCardWidget(
                  ownerData: equipmentData["owner"] as Map<String, dynamic>,
                  onContactPressed: _contactOwner,
                ),
              ),

              // Equipment Specifications
              SliverToBoxAdapter(
                child: EquipmentSpecificationsWidget(
                  specifications:
                      equipmentData["specifications"] as Map<String, dynamic>,
                  description: equipmentData["description"] as String,
                  location: equipmentData["location"] as String,
                  safetyFeatures:
                      (equipmentData["safetyFeatures"] as List).cast<String>(),
                  insurance: equipmentData["insurance"] as String,
                ),
              ),

              // Availability Calendar
              SliverToBoxAdapter(
                child: AvailabilityCalendarWidget(),
              ),

              // Reviews Section
              SliverToBoxAdapter(
                child: ReviewsSectionWidget(
                  reviews: reviewsData,
                  averageRating: equipmentData["rating"] as double,
                  totalReviews: equipmentData["reviewCount"] as int,
                ),
              ),

              // Similar Equipment
              SliverToBoxAdapter(
                child: SimilarEquipmentWidget(
                  similarEquipment: similarEquipmentData,
                ),
              ),

              // Bottom padding for floating button
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),

          // Floating Action Button
          if (_showFloatingButton)
            Positioned(
              bottom: 3.h,
              left: 4.w,
              right: 4.w,
              child: SizedBox(
                width: double.infinity,
                height: 7.h,
                child: ElevatedButton(
                  onPressed: _showBookingBottomSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                    foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                    elevation: 8,
                    shadowColor: AppTheme.lightTheme.colorScheme.shadow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'calendar_today',
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Book Equipment',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
