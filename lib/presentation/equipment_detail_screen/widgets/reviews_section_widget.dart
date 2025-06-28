import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ReviewsSectionWidget extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;
  final double averageRating;
  final int totalReviews;

  const ReviewsSectionWidget({
    super.key,
    required this.reviews,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  State<ReviewsSectionWidget> createState() => _ReviewsSectionWidgetState();
}

class _ReviewsSectionWidgetState extends State<ReviewsSectionWidget> {
  bool _showAllReviews = false;

  @override
  Widget build(BuildContext context) {
    final displayedReviews =
        _showAllReviews ? widget.reviews : widget.reviews.take(2).toList();

    return Container(
      margin: EdgeInsets.all(4.w),
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
          // Header with rating summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews & Ratings',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all reviews screen
                },
                child: Text(
                  'View All',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Rating summary
          _buildRatingSummary(),
          SizedBox(height: 3.h),

          // Reviews list
          if (widget.reviews.isNotEmpty) ...[
            ...displayedReviews.map((review) => _buildReviewCard(review)),
            if (widget.reviews.length > 2)
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showAllReviews = !_showAllReviews;
                    });
                  },
                  child: Text(
                    _showAllReviews ? 'Show Less' : 'Show More Reviews',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
          ] else
            _buildNoReviewsState(),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Average rating
          Column(
            children: [
              Text(
                widget.averageRating.toStringAsFixed(1),
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return CustomIconWidget(
                    iconName: index < widget.averageRating.floor()
                        ? 'star'
                        : 'star_border',
                    color: AppTheme.getAccentColor(true),
                    size: 4.w,
                  );
                }),
              ),
              SizedBox(height: 0.5.h),
              Text(
                '${widget.totalReviews} reviews',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(width: 6.w),

          // Rating breakdown
          Expanded(
            child: Column(
              children: [
                _buildRatingBar(5, 85),
                _buildRatingBar(4, 10),
                _buildRatingBar(3, 3),
                _buildRatingBar(2, 1),
                _buildRatingBar(1, 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, int percentage) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.5.h),
      child: Row(
        children: [
          Text(
            '$stars',
            style: AppTheme.lightTheme.textTheme.bodySmall,
          ),
          SizedBox(width: 1.w),
          CustomIconWidget(
            iconName: 'star',
            color: AppTheme.getAccentColor(true),
            size: 3.w,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Container(
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.getAccentColor(true),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            '$percentage%',
            style: AppTheme.lightTheme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    final images = (review["images"] as List?)?.cast<String>() ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info and rating
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: ClipOval(
                  child: CustomImageWidget(
                    imageUrl: review["userAvatar"] ?? "",
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review["userName"] ?? "Anonymous",
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = review["rating"] as double? ?? 0.0;
                            return CustomIconWidget(
                              iconName: index < rating.floor()
                                  ? 'star'
                                  : 'star_border',
                              color: AppTheme.getAccentColor(true),
                              size: 3.5.w,
                            );
                          }),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          review["date"] ?? "",
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Review comment
          Text(
            review["comment"] ?? "",
            style: AppTheme.lightTheme.textTheme.bodyLarge,
          ),

          // Review images
          if (images.isNotEmpty) ...[
            SizedBox(height: 2.h),
            SizedBox(
              height: 20.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 2.w),
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomImageWidget(
                        imageUrl: images[index],
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoReviewsState() {
    return Container(
      padding: EdgeInsets.all(6.w),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'rate_review',
            color: AppTheme.lightTheme.colorScheme.outline,
            size: 12.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'No reviews yet',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Be the first to review this equipment',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
