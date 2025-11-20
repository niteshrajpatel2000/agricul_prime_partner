import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final salaryController = TextEditingController();
  final birthDateController = TextEditingController();
  final joinDateController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? selectJoiningDate;
  String? selectBirthDate;
  String? selectedDesignation;
  String? selectedDepartment;
  String? selectedGender;
  String? selectedStatus;
  String? selectShift;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    salaryController.dispose();
    birthDateController.dispose();
    joinDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEdit == true ? 'Edit Employee' : 'Add New Employee',
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 2,
            color: kBackgroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Select full name',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter your name' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Designation',
                    hintText: 'Select one',
                  ),
                  value: selectedDesignation,
                  validator: (value) =>
                      value == null ? 'Please select your designation' : null,
                  items: [
                    'Sales & Marketing',
                    'Flutter Developer',
                  ].map((entry) {
                    return DropdownMenuItem(value: entry, child: Text(entry));
                  }).toList(),
                  onChanged: (String? value) {
                    selectedDesignation = value;
                  }),
              SizedBox(height: 20),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Department',
                    hintText: 'Select one',
                  ),
                  value: selectedDepartment,
                  validator: (value) =>
                      value == null ? 'Please select your department' : null,
                  items: [
                    'Manager',
                    'CEO',
                  ].map((entry) {
                    return DropdownMenuItem(value: entry, child: Text(entry));
                  }).toList(),
                  onChanged: (String? value) {
                    selectedDepartment = value;
                  }),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter Your Email' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter Your phone' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: countryController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Country Name',
                  hintText: 'Enter your country',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter Your Country' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: salaryController,
                decoration: InputDecoration(
                  labelText: 'Salary',
                  hintText: 'Ex: \$500',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter Your Salary' : null,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          hintText: 'Select one',
                        ),
                        value: selectedDepartment,
                        validator: (value) =>
                            value == null ? 'Please select your Gender' : null,
                        items: [
                          'Male',
                          'Female',
                          'Others',
                        ].map((entry) {
                          return DropdownMenuItem(
                              value: entry, child: Text(entry));
                        }).toList(),
                        onChanged: (String? value) {
                          selectedDepartment = value;
                        }),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Shift',
                          hintText: 'Select one',
                        ),
                        value: selectShift,
                        validator: (value) => value == null
                            ? 'Please select your department'
                            : null,
                        items: [
                          'Morning',
                          'Day',
                          'Night',
                        ].map((entry) {
                          return DropdownMenuItem(
                              value: entry, child: Text(entry));
                        }).toList(),
                        onChanged: (String? value) {
                          selectShift = value;
                        }),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      controller: birthDateController,
                      decoration: InputDecoration(
                        labelText: 'Birth Date',
                        hintText: '06/02/2025',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101),
                              context: context,
                            );
                            setState(() {
                              if (picked != null) {
                                birthDateController.text =
                                    DateFormat('dd/MM/yyyy').format(picked);
                                selectBirthDate = picked.toString();
                              } else {
                                birthDateController.text =
                                    birthDateController.text;
                              }
                            });
                          },
                          icon: const Icon(IconlyLight.calendar, size: 22),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      controller: joinDateController,
                      decoration: InputDecoration(
                        labelText: 'Join Date',
                        hintText: '06/02/2025',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101),
                              context: context,
                            );
                            setState(() {
                              if (picked != null) {
                                joinDateController.text =
                                    DateFormat('dd/MM/yyyy').format(picked);
                                selectJoiningDate = picked.toString();
                              } else {
                                joinDateController.text =
                                    birthDateController.text;
                              }
                            });
                          },
                          icon: const Icon(IconlyLight.calendar, size: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Status',
                          hintText: 'Select one',
                        ),
                        value: selectedDepartment,
                        validator: (value) =>
                            value == null ? 'Please select Status' : null,
                        items: [
                          'Active',
                          'InActive',
                        ].map((entry) {
                          return DropdownMenuItem(
                              value: entry, child: Text(entry));
                        }).toList(),
                        onChanged: (String? value) {
                          selectedDepartment = value;
                        }),
                  ),
                  SizedBox(width: 16),
                  Expanded(child: SizedBox())
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Image',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width - 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _imageOption(
                                  icon: Icons.photo_library_rounded,
                                  label: 'Gallery',
                                  color: kMainColor,
                                  source: ImageSource.gallery,
                                ),
                                const SizedBox(width: 40),
                                _imageOption(
                                  icon: Icons.camera,
                                  label: 'Camera',
                                  color: kGreyTextColor,
                                  source: ImageSource.camera,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(120),
                              image: DecorationImage(
                                image: pickedImage != null
                                    ? FileImage(File(pickedImage!.path))
                                    : AssetImage('assets/hrm/image_icon.jpg')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: kMainColor,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(120),
                              ),
                              child: const Icon(Icons.camera_alt_outlined,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _key.currentState?.reset();
                          nameController.clear();
                          emailController.clear();
                          phoneController.clear();
                          countryController.clear();
                          salaryController.clear();
                          birthDateController.clear();
                          joinDateController.clear();
                          selectedDesignation = null;
                          selectedDepartment = null;
                          selectedGender = null;
                          selectedStatus = null;
                        });
                      },
                      child: Text('Reset'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(widget.isEdit == true ? 'Update' : 'Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper Widget
  Widget _imageOption({
    required IconData icon,
    required String label,
    required Color color,
    required ImageSource source,
  }) {
    return GestureDetector(
      onTap: () async {
        final navigator = Navigator.of(context); // capture context safely
        pickedImage = await _picker.pickImage(source: source);
        setState(() {});
        Future.delayed(
          const Duration(milliseconds: 100),
          () => navigator.pop(), // use the captured navigator
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: color),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: kGreyTextColor)),
        ],
      ),
    );
  }
}
