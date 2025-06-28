import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HireWorkerBottomSheet extends StatefulWidget {
  final Map<String, dynamic> workerData;

  const HireWorkerBottomSheet({
    super.key,
    required this.workerData,
  });

  @override
  State<HireWorkerBottomSheet> createState() => _HireWorkerBottomSheetState();
}

class _HireWorkerBottomSheetState extends State<HireWorkerBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _durationController = TextEditingController();
  final _rateController = TextEditingController();
  final _notesController = TextEditingController();

  String selectedEquipment = 'Tractor';
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  final List<String> equipmentTypes = [
    'Tractor',
    'Harvester',
    'Planter',
    'Cultivator',
    'Irrigation System',
    'Transport Vehicle',
  ];

  @override
  void dispose() {
    _taskController.dispose();
    _durationController.dispose();
    _rateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return DatePickerTheme(
              data: DatePickerThemeData(
                  backgroundColor: AppTheme.lightTheme.cardColor,
                  headerBackgroundColor: AppTheme.lightTheme.primaryColor,
                  headerForegroundColor: Colors.white),
              child: child!);
        });

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _submitJobRequest() {
    if (_formKey.currentState!.validate()) {
      // Handle job request submission
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Job request sent to ${widget.workerData["name"]}!'),
          backgroundColor: AppTheme.getSuccessColor(true)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 85.h,
        decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(children: [
          // Handle
          Container(
              margin: EdgeInsets.only(top: 1.h),
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10))),

          // Header
          Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(children: [
                Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                        child: CustomImageWidget(
                            imageUrl:
                                widget.workerData["profileImage"] as String,
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.cover))),
                SizedBox(width: 3.w),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('Hire ${widget.workerData["name"]}',
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text('Create a job request',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                                  color: AppTheme.lightTheme.colorScheme
                                      .onSurfaceVariant)),
                    ])),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 24)),
              ])),

          Divider(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
              height: 1),

          // Form
          Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(4.w),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Task Description
                            Text('Task Description',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            SizedBox(height: 1.h),
                            TextFormField(
                                controller: _taskController,
                                decoration: const InputDecoration(
                                    hintText:
                                        'Describe the work to be done...'),
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please describe the task';
                                  }
                                  return null;
                                }),

                            SizedBox(height: 3.h),

                            // Equipment Type
                            Text('Equipment Required',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            SizedBox(height: 1.h),
                            DropdownButtonFormField<String>(
                                value: selectedEquipment,
                                decoration: const InputDecoration(
                                    hintText: 'Select equipment type'),
                                items: equipmentTypes.map((equipment) {
                                  return DropdownMenuItem(
                                      value: equipment, child: Text(equipment));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedEquipment = value!;
                                  });
                                }),

                            SizedBox(height: 3.h),

                            // Date and Time
                            Row(children: [
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('Start Date',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    SizedBox(height: 1.h),
                                    GestureDetector(
                                        onTap: _selectDate,
                                        child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppTheme.lightTheme
                                                        .colorScheme.outline),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(children: [
                                              CustomIconWidget(
                                                  iconName: 'calendar_today',
                                                  color: AppTheme
                                                      .lightTheme
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                  size: 20),
                                              SizedBox(width: 2.w),
                                              Text(
                                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                                  style: AppTheme.lightTheme
                                                      .textTheme.bodyMedium),
                                            ]))),
                                  ])),
                              SizedBox(width: 3.w),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('Start Time',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    SizedBox(height: 1.h),
                                    GestureDetector(
                                        onTap: _selectTime,
                                        child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppTheme.lightTheme
                                                        .colorScheme.outline),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(children: [
                                              CustomIconWidget(
                                                  iconName: 'access_time',
                                                  color: AppTheme
                                                      .lightTheme
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                  size: 20),
                                              SizedBox(width: 2.w),
                                              Text(selectedTime.format(context),
                                                  style: AppTheme.lightTheme
                                                      .textTheme.bodyMedium),
                                            ]))),
                                  ])),
                            ]),

                            SizedBox(height: 3.h),

                            // Duration and Rate
                            Row(children: [
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('Duration (hours)',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                        controller: _durationController,
                                        decoration: const InputDecoration(
                                            hintText: 'e.g., 8'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required';
                                          }
                                          return null;
                                        }),
                                  ])),
                              SizedBox(width: 3.w),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('Offered Rate (\$/hr)',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                        controller: _rateController,
                                        decoration: InputDecoration(
                                            hintText:
                                                widget.workerData["hourlyRate"]
                                                    as String),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required';
                                          }
                                          return null;
                                        }),
                                  ])),
                            ]),

                            SizedBox(height: 3.h),

                            // Additional Notes
                            Text('Additional Notes (Optional)',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            SizedBox(height: 1.h),
                            TextFormField(
                                controller: _notesController,
                                decoration: const InputDecoration(
                                    hintText:
                                        'Any special requirements or instructions...'),
                                maxLines: 2),

                            SizedBox(height: 4.h),
                          ])))),

          // Submit Button
          Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                  color: AppTheme.lightTheme.cardColor,
                  border: Border(
                      top: BorderSide(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.2)))),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _submitJobRequest,
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 2.h)),
                      child: Text('Send Job Request',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))))),
        ]));
  }
}
