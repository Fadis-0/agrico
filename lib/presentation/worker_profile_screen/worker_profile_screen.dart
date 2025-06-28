import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/hire_worker_bottom_sheet.dart';
import './widgets/similar_workers_widget.dart';
import './widgets/worker_availability_widget.dart';
import './widgets/worker_experience_widget.dart';
import './widgets/worker_header_widget.dart';
import './widgets/worker_reviews_widget.dart';
import './widgets/worker_skills_widget.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  bool isFavorite = false;

  // Mock worker data
  final Map<String, dynamic> workerData = {
    "id": 1,
    "name": "Carlos Rodriguez",
    "profileImage":
        "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg",
    "specializations": [
      "Tractor Operator",
      "Harvester Specialist",
      "Transporter"
    ],
    "rating": 4.8,
    "reviewCount": 127,
    "isAvailable": true,
    "location": "Central Valley, CA",
    "radius": "25 miles",
    "experience": "8+ years",
    "hourlyRate": "\$35-45",
    "description":
        "Experienced agricultural worker specializing in large-scale farming operations. Expert in modern farming equipment with certifications in safety protocols.",
    "skills": [
      {"name": "Tractors", "level": "Expert"},
      {"name": "Combines", "level": "Expert"},
      {"name": "Irrigation", "level": "Advanced"},
      {"name": "Livestock", "level": "Intermediate"}
    ],
    "certifications": [
      "Commercial Driver's License",
      "Agricultural Safety Certification",
      "Equipment Operation License"
    ],
    "workHistory": [
      {
        "farmName": "Green Valley Farms",
        "duration": "2022-2023",
        "rating": 5.0,
        "task": "Harvest Operations",
        "image":
            "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg"
      },
      {
        "farmName": "Sunrise Agriculture",
        "duration": "2021-2022",
        "rating": 4.9,
        "task": "Planting & Cultivation",
        "image":
            "https://images.pexels.com/photos/1595104/pexels-photo-1595104.jpeg"
      }
    ],
    "availability": {
      "preferredHours": "6:00 AM - 6:00 PM",
      "blockedDates": ["2024-01-15", "2024-01-20", "2024-01-25"]
    },
    "verification": {
      "backgroundCheck": true,
      "insurance": true,
      "certifications": true
    },
    "contact": {
      "phone": "+1 (555) 123-4567",
      "messaging": true,
      "locationSharing": true
    }
  };

  final List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "farmerName": "John Smith",
      "farmerImage":
          "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg",
      "rating": 5.0,
      "date": "2023-12-15",
      "comment":
          "Carlos did an excellent job with our harvest. Very professional and efficient with the equipment.",
      "jobType": "Harvest Operations",
      "workImage":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg"
    },
    {
      "id": 2,
      "farmerName": "Maria Garcia",
      "farmerImage":
          "https://images.pexels.com/photos/1181690/pexels-photo-1181690.jpeg",
      "rating": 4.8,
      "date": "2023-11-28",
      "comment":
          "Great work on the planting operations. Carlos knows his equipment very well.",
      "jobType": "Planting Operations",
      "workImage":
          "https://images.pexels.com/photos/1595104/pexels-photo-1595104.jpeg"
    }
  ];

  final List<Map<String, dynamic>> similarWorkers = [
    {
      "id": 2,
      "name": "Miguel Santos",
      "image":
          "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg",
      "specialization": "Irrigation Specialist",
      "rating": 4.7,
      "distance": "12 miles",
      "hourlyRate": "\$30-40"
    },
    {
      "id": 3,
      "name": "David Johnson",
      "image":
          "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
      "specialization": "Equipment Operator",
      "rating": 4.6,
      "distance": "18 miles",
      "hourlyRate": "\$32-42"
    }
  ];

  void _showHireWorkerBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HireWorkerBottomSheet(workerData: workerData),
    );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _contactWorker() {
    // Handle contact worker action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening contact options...'),
        backgroundColor: AppTheme.lightTheme.primaryColor,
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
            slivers: [
              SliverAppBar(
                expandedHeight: 30.h,
                pinned: true,
                backgroundColor: AppTheme.lightTheme.primaryColor,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: _contactWorker,
                    icon: CustomIconWidget(
                      iconName: 'phone',
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFavorite,
                    icon: CustomIconWidget(
                      iconName: isFavorite ? 'favorite' : 'favorite_border',
                      color: isFavorite
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 2.w),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: WorkerHeaderWidget(
                    workerData: workerData,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),

                    // Skills Section
                    WorkerSkillsWidget(
                      skills: (workerData["skills"] as List)
                          .cast<Map<String, dynamic>>(),
                      certifications:
                          (workerData["certifications"] as List).cast<String>(),
                      verification:
                          workerData["verification"] as Map<String, dynamic>,
                    ),

                    SizedBox(height: 2.h),

                    // Experience Section
                    WorkerExperienceWidget(
                      workHistory: (workerData["workHistory"] as List)
                          .cast<Map<String, dynamic>>(),
                      description: workerData["description"] as String,
                    ),

                    SizedBox(height: 2.h),

                    // Availability Section
                    WorkerAvailabilityWidget(
                      availability:
                          workerData["availability"] as Map<String, dynamic>,
                      isAvailable: workerData["isAvailable"] as bool,
                    ),

                    SizedBox(height: 2.h),

                    // Reviews Section
                    WorkerReviewsWidget(
                      reviews: reviews,
                      rating: workerData["rating"] as double,
                      reviewCount: workerData["reviewCount"] as int,
                    ),

                    SizedBox(height: 2.h),

                    // Similar Workers Section
                    SimilarWorkersWidget(
                      similarWorkers: similarWorkers,
                    ),

                    SizedBox(height: 10.h), // Space for FAB
                  ],
                ),
              ),
            ],
          ),

          // Floating Action Button
          Positioned(
            bottom: 3.h,
            right: 4.w,
            child: FloatingActionButton.extended(
              onPressed: _showHireWorkerBottomSheet,
              backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
              foregroundColor: Colors.white,
              icon: CustomIconWidget(
                iconName: 'work',
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                'Hire Worker',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
