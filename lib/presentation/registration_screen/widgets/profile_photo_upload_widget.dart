import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfilePhotoUploadWidget extends StatelessWidget {
  final String? profileImagePath;
  final Function(String?) onImageSelected;

  const ProfilePhotoUploadWidget({
    super.key,
    required this.profileImagePath,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Photo',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 1.h),
        Text(
          'Add a profile photo to help others recognize you (optional)',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 2.h),
        Center(
          child: GestureDetector(
            onTap: () => _showImageSourceDialog(context),
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: profileImagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.w),
                      child: CustomImageWidget(
                        imageUrl: profileImagePath!,
                        width: 30.w,
                        height: 30.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'camera_alt',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 32,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Add Photo',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        if (profileImagePath != null) ...[
          SizedBox(height: 2.h),
          Center(
            child: TextButton.icon(
              onPressed: () => onImageSelected(null),
              icon: CustomIconWidget(
                iconName: 'delete',
                color: AppTheme.lightTheme.colorScheme.error,
                size: 16,
              ),
              label: Text(
                'Remove Photo',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12.w,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Select Photo Source',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                SizedBox(height: 3.h),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: 'camera_alt',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    'Camera',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Take a new photo',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _selectImageFromCamera();
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.secondary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: 'photo_library',
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    'Gallery',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Choose from gallery',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _selectImageFromGallery();
                  },
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectImageFromCamera() {
    // Simulate camera image selection
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock image URL for demonstration
      onImageSelected(
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face');
    });
  }

  void _selectImageFromGallery() {
    // Simulate gallery image selection
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock image URL for demonstration
      onImageSelected(
          'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?w=150&h=150&fit=crop&crop=face');
    });
  }
}
