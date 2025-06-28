import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/profile_photo_upload_widget.dart';
import './widgets/registration_form_widget.dart';
import './widgets/user_type_selection_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _farmSizeController = TextEditingController();

  // State variables
  int _currentStep = 0;
  String _selectedUserType = '';
  String _selectedExperience = '';
  String _selectedSpecialization = '';
  String? _profileImagePath;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;
  bool _isLoading = false;
  double _passwordStrength = 0.0;

  final List<String> _experienceLevels = [
    'Beginner (0-2 years)',
    'Intermediate (3-5 years)',
    'Experienced (6-10 years)',
    'Expert (10+ years)'
  ];

  final List<String> _specializations = [
    'Tractor Operation',
    'Harvesting Equipment',
    'Irrigation Systems',
    'Planting Equipment',
    'Transportation',
    'General Farm Equipment'
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _locationController.dispose();
    _farmSizeController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _calculatePasswordStrength(String password) {
    double strength = 0.0;
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
    });
  }

  bool _isFormValid() {
    return _selectedUserType.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text &&
        _passwordStrength >= 0.5 &&
        _acceptTerms &&
        (_selectedUserType == 'Farmer'
            ? _farmSizeController.text.isNotEmpty
            : (_selectedExperience.isNotEmpty &&
                _selectedSpecialization.isNotEmpty));
  }

  Future<void> _submitRegistration() async {
    if (!_isFormValid()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success dialog
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            children: [
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.getSuccessColor(true),
                size: 48,
              ),
              SizedBox(height: 2.h),
              Text(
                'Registration Successful!',
                style: AppTheme.lightTheme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            'Your account has been created successfully. Please check your email for verification instructions before accessing the marketplace.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login-screen');
                },
                child: const Text('Continue to Login'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed:
              _currentStep > 0 ? _previousStep : () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Text(
          'Create Account',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Column(
              children: [
                Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= _currentStep
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Step ${_currentStep + 1} of 3',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Step 1: User Type Selection
                _buildUserTypeStep(),

                // Step 2: Basic Information
                _buildBasicInfoStep(),

                // Step 3: Additional Details & Completion
                _buildAdditionalDetailsStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Role',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Select the role that best describes you in the agricultural marketplace.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 4.h),
          UserTypeSelectionWidget(
            selectedUserType: _selectedUserType,
            onUserTypeChanged: (String userType) {
              setState(() {
                _selectedUserType = userType;
              });
            },
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedUserType.isNotEmpty ? _nextStep : null,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: AppTheme.lightTheme.textTheme.headlineSmall,
            ),
            SizedBox(height: 1.h),
            Text(
              'Please provide your basic details to create your account.',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4.h),
            RegistrationFormWidget(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              locationController: _locationController,
              isPasswordVisible: _isPasswordVisible,
              isConfirmPasswordVisible: _isConfirmPasswordVisible,
              passwordStrength: _passwordStrength,
              onPasswordVisibilityToggle: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              onConfirmPasswordVisibilityToggle: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
              onPasswordChanged: _calculatePasswordStrength,
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _previousStep,
                    child: const Text('Back'),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty &&
                            _locationController.text.isNotEmpty &&
                            _passwordStrength >= 0.5
                        ? _nextStep
                        : null,
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complete Your Profile',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Add additional details to help others find and connect with you.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 4.h),

          // Profile Photo Upload
          ProfilePhotoUploadWidget(
            profileImagePath: _profileImagePath,
            onImageSelected: (String? imagePath) {
              setState(() {
                _profileImagePath = imagePath;
              });
            },
          ),

          SizedBox(height: 4.h),

          // Agricultural-specific fields
          if (_selectedUserType == 'Farmer') ...[
            TextFormField(
              controller: _farmSizeController,
              decoration: const InputDecoration(
                labelText: 'Farm Size (acres)',
                hintText: 'Enter your farm size',
                prefixIcon: Icon(Icons.landscape),
              ),
              keyboardType: TextInputType.number,
            ),
          ] else if (_selectedUserType == 'Worker') ...[
            DropdownButtonFormField<String>(
              value: _selectedExperience.isEmpty ? null : _selectedExperience,
              decoration: const InputDecoration(
                labelText: 'Experience Level',
                prefixIcon: Icon(Icons.work),
              ),
              items: _experienceLevels.map((String experience) {
                return DropdownMenuItem<String>(
                  value: experience,
                  child: Text(experience),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedExperience = value ?? '';
                });
              },
            ),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              value: _selectedSpecialization.isEmpty
                  ? null
                  : _selectedSpecialization,
              decoration: const InputDecoration(
                labelText: 'Equipment Specialization',
                prefixIcon: Icon(Icons.build),
              ),
              items: _specializations.map((String specialization) {
                return DropdownMenuItem<String>(
                  value: specialization,
                  child: Text(specialization),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedSpecialization = value ?? '';
                });
              },
            ),
          ],

          SizedBox(height: 4.h),

          // Terms and Conditions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _acceptTerms,
                onChanged: (bool? value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _acceptTerms = !_acceptTerms;
                    });
                  },
                  child: Text(
                    'I agree to the Terms of Service and Privacy Policy for the agricultural marketplace.',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  child: const Text('Back'),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isFormValid() && !_isLoading
                      ? _submitRegistration
                      : null,
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.lightTheme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : const Text('Create Account'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
