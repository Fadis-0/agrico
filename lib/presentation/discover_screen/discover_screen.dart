import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/equipment_card_widget.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/search_header_widget.dart';
import './widgets/terrain_card_widget.dart';
import './widgets/worker_card_widget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isMapView = false;
  int _activeFilterCount = 3;
  String _selectedCategory = 'Equipment';

  // Mock data for equipment listings
  final List<Map<String, dynamic>> equipmentData = [
    {
      "id": 1,
      "title": "John Deere 6120M Tractor",
      "description":
          "Powerful 120HP tractor perfect for medium to large farming operations",
      "price": "\$850/day",
      "location": "2.3 km away",
      "availability": "Available",
      "rating": 4.8,
      "reviews": 24,
      "image":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg",
      "owner": "Mike Johnson",
      "specifications": ["120HP", "4WD", "Air Conditioned"],
      "isFavorite": false,
    },
    {
      "id": 2,
      "title": "Case IH Combine Harvester",
      "description":
          "High-efficiency combine harvester for wheat, corn, and soybean harvesting",
      "price": "\$1,200/day",
      "location": "5.7 km away",
      "availability": "Available",
      "rating": 4.9,
      "reviews": 18,
      "image":
          "https://images.pexels.com/photos/2132251/pexels-photo-2132251.jpeg",
      "owner": "Sarah Wilson",
      "specifications": ["300HP", "GPS Guided", "Grain Tank"],
      "isFavorite": true,
    },
    {
      "id": 3,
      "title": "Kubota M7-172 Tractor",
      "description":
          "Versatile tractor with advanced hydraulics for precision farming",
      "price": "\$750/day",
      "location": "8.1 km away",
      "availability": "Busy until Oct 25",
      "rating": 4.7,
      "reviews": 31,
      "image":
          "https://images.pexels.com/photos/2132252/pexels-photo-2132252.jpeg",
      "owner": "David Chen",
      "specifications": ["172HP", "CVT Transmission", "Front Loader"],
      "isFavorite": false,
    },
  ];

  // Mock data for terrain listings
  final List<Map<String, dynamic>> terrainData = [
    {
      "id": 1,
      "title": "Premium Farmland - 50 Acres",
      "description":
          "Fertile soil perfect for corn and soybean cultivation with irrigation system",
      "price": "\$200/acre/season",
      "location": "3.2 km away",
      "availability": "Available for Spring 2024",
      "rating": 4.9,
      "reviews": 12,
      "image":
          "https://images.pexels.com/photos/974314/pexels-photo-974314.jpeg",
      "owner": "Green Valley Farms",
      "specifications": ["Irrigated", "Organic Certified", "Clay Loam Soil"],
      "isFavorite": true,
    },
    {
      "id": 2,
      "title": "Organic Certified Land - 25 Acres",
      "description":
          "USDA organic certified farmland ideal for vegetable production",
      "price": "\$300/acre/season",
      "location": "6.8 km away",
      "availability": "Available",
      "rating": 4.8,
      "reviews": 8,
      "image":
          "https://images.pexels.com/photos/1595104/pexels-photo-1595104.jpeg",
      "owner": "Organic Fields Co.",
      "specifications": ["Organic Certified", "Well Water", "Sandy Loam"],
      "isFavorite": false,
    },
  ];

  // Mock data for worker listings
  final List<Map<String, dynamic>> workerData = [
    {
      "id": 1,
      "title": "Experienced Tractor Operator",
      "description":
          "15+ years experience operating heavy agricultural machinery",
      "price": "\$25/hour",
      "location": "4.1 km away",
      "availability": "Available weekdays",
      "rating": 4.9,
      "reviews": 47,
      "image":
          "https://images.pexels.com/photos/1181467/pexels-photo-1181467.jpeg",
      "owner": "Carlos Rodriguez",
      "specifications": ["CDL License", "Equipment Certified", "Insured"],
      "isFavorite": false,
    },
    {
      "id": 2,
      "title": "Harvest Crew Leader",
      "description":
          "Professional harvest operations with full crew management",
      "price": "\$35/hour",
      "location": "7.3 km away",
      "availability": "Available",
      "rating": 4.8,
      "reviews": 23,
      "image":
          "https://images.pexels.com/photos/1181468/pexels-photo-1181468.jpeg",
      "owner": "Maria Santos",
      "specifications": ["Crew of 6", "Own Tools", "Flexible Schedule"],
      "isFavorite": true,
    },
  ];

  final List<String> activeFilters = [
    "Within 10km",
    "\$500-\$1000/day",
    "Available Now"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          switch (_tabController.index) {
            case 0:
              _selectedCategory = 'Equipment';
              break;
            case 1:
              _selectedCategory = 'Terrain';
              break;
            case 2:
              _selectedCategory = 'Workers';
              break;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleMapView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  void _removeFilter(String filter) {
    setState(() {
      activeFilters.remove(filter);
      _activeFilterCount = activeFilters.length;
    });
  }

  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterModal(),
    );
  }

  Widget _buildFilterModal() {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              children: [
                _buildFilterSection('Location', [
                  'Within 5km',
                  'Within 10km',
                  'Within 25km',
                  'Within 50km'
                ]),
                SizedBox(height: 3.h),
                _buildFilterSection('Price Range', [
                  'Under \$500/day',
                  '\$500-\$1000/day',
                  '\$1000-\$2000/day',
                  'Over \$2000/day'
                ]),
                SizedBox(height: 3.h),
                _buildFilterSection('Availability', [
                  'Available Now',
                  'Available This Week',
                  'Available This Month',
                  'Seasonal Availability'
                ]),
                SizedBox(height: 3.h),
                if (_selectedCategory == 'Equipment')
                  _buildFilterSection('Equipment Type', [
                    'Tractors',
                    'Harvesters',
                    'Planting Equipment',
                    'Irrigation Systems'
                  ]),
                if (_selectedCategory == 'Terrain')
                  _buildFilterSection('Soil Type',
                      ['Clay Loam', 'Sandy Loam', 'Silt Loam', 'Sandy Clay']),
                if (_selectedCategory == 'Workers')
                  _buildFilterSection('Skills', [
                    'Tractor Operation',
                    'Harvest Crew',
                    'Equipment Maintenance',
                    'Transportation'
                  ]),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        activeFilters.clear();
                        _activeFilterCount = 0;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Clear All'),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            final isSelected = activeFilters.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    activeFilters.add(option);
                  } else {
                    activeFilters.remove(option);
                  }
                  _activeFilterCount = activeFilters.length;
                });
              },
              selectedColor: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.2),
              checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    if (_isMapView) {
      return _buildMapView();
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildEquipmentList(),
        _buildTerrainList(),
        _buildWorkerList(),
      ],
    );
  }

  Widget _buildMapView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'map',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 64,
            ),
            SizedBox(height: 2.h),
            Text(
              'Map View',
              style: AppTheme.lightTheme.textTheme.headlineSmall,
            ),
            SizedBox(height: 1.h),
            Text(
              'Geographic distribution of $_selectedCategory',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentList() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h),
        itemCount: equipmentData.length,
        itemBuilder: (context, index) {
          final equipment = equipmentData[index];
          return EquipmentCardWidget(
            equipment: equipment,
            onTap: () =>
                Navigator.pushNamed(context, '/equipment-detail-screen'),
            onFavoriteToggle: () {
              setState(() {
                equipment['isFavorite'] = !equipment['isFavorite'];
              });
            },
            onShare: () {
              // Share functionality
            },
            onContact: () {
              // Contact functionality
            },
          );
        },
      ),
    );
  }

  Widget _buildTerrainList() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h),
        itemCount: terrainData.length,
        itemBuilder: (context, index) {
          final terrain = terrainData[index];
          return TerrainCardWidget(
            terrain: terrain,
            onTap: () => Navigator.pushNamed(context, '/terrain-detail-screen'),
            onFavoriteToggle: () {
              setState(() {
                terrain['isFavorite'] = !terrain['isFavorite'];
              });
            },
            onShare: () {
              // Share functionality
            },
            onContact: () {
              // Contact functionality
            },
          );
        },
      ),
    );
  }

  Widget _buildWorkerList() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h),
        itemCount: workerData.length,
        itemBuilder: (context, index) {
          final worker = workerData[index];
          return WorkerCardWidget(
            worker: worker,
            onTap: () => Navigator.pushNamed(context, '/worker-profile-screen'),
            onFavoriteToggle: () {
              setState(() {
                worker['isFavorite'] = !worker['isFavorite'];
              });
            },
            onShare: () {
              // Share functionality
            },
            onContact: () {
              // Contact functionality
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchHeaderWidget(
              controller: _searchController,
              activeFilterCount: _activeFilterCount,
              onFilterTap: _openFilterModal,
              onVoiceSearch: () {
                // Voice search functionality
              },
            ),
            if (activeFilters.isNotEmpty)
              Container(
                height: 6.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: activeFilters.length,
                  itemBuilder: (context, index) {
                    return FilterChipWidget(
                      label: activeFilters[index],
                      onRemove: () => _removeFilter(activeFilters[index]),
                    );
                  },
                ),
              ),
            Container(
              color: AppTheme.lightTheme.colorScheme.surface,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Equipment'),
                  Tab(text: 'Terrain'),
                  Tab(text: 'Workers'),
                ],
              ),
            ),
            Expanded(
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "map_toggle",
            onPressed: _toggleMapView,
            backgroundColor: AppTheme.lightTheme.colorScheme.surface,
            foregroundColor: AppTheme.lightTheme.colorScheme.primary,
            child: CustomIconWidget(
              iconName: _isMapView ? 'list' : 'map',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
          ),
          SizedBox(height: 2.h),
          FloatingActionButton.extended(
            heroTag: "post_listing",
            onPressed: () {
              // Navigate to post listing screen
            },
            backgroundColor: AppTheme.lightTheme.colorScheme.primary,
            foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
            icon: CustomIconWidget(
              iconName: 'add',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 24,
            ),
            label: Text('Post Your Own'),
          ),
        ],
      ),
    );
  }
}
