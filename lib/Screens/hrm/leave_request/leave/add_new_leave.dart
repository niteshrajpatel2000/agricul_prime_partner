import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../constant.dart';

class AddNewLeave extends StatefulWidget {
  const AddNewLeave({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewLeave> createState() => _AddNewLeaveState();
}

class _AddNewLeaveState extends State<AddNewLeave> {
  String? selectEmployee;
  String? selectDepartment;
  String? selectLeaveType;
  String? selectMonth;
  String? selectStatus;
  String? selectStartDate;
  String? selectEndDate;
  final GlobalKey<FormState> _key = GlobalKey();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final leaveDurationController = TextEditingController();
  final noteController = TextEditingController();
  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    leaveDurationController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEdit == true ? 'Edit Leave' : 'Add New Leave',
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
            children: [
              DropdownButtonFormField(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: kNeutral800,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Employee',
                    hintText: 'Select one',
                  ),
                  value: selectEmployee,
                  validator: (value) =>
                      value == null ? 'Please select a employee' : null,
                  items: [
                    'Sahidul Islam',
                    'Ibne Riyad',
                  ].map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectEmployee = value;
                  }),
              SizedBox(height: 20),
              DropdownButtonFormField(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: kNeutral800,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Department',
                    hintText: 'Select one',
                  ),
                  value: selectDepartment,
                  validator: (value) =>
                      value == null ? 'Please select department' : null,
                  items: [
                    'Manager',
                    'Human Resources',
                  ].map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectDepartment = value;
                  }),
              SizedBox(height: 20),
              DropdownButtonFormField(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: kNeutral800,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Leave Type',
                    hintText: 'Select one',
                  ),
                  value: selectLeaveType,
                  validator: (value) =>
                      value == null ? 'Please select department' : null,
                  items: [
                    'Sick Leave',
                    'Casual Leave',
                  ].map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectLeaveType = value;
                  }),
              SizedBox(height: 20),
              DropdownButtonFormField(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: kNeutral800,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Month',
                    hintText: 'Select one',
                  ),
                  value: selectDepartment,
                  validator: (value) =>
                      value == null ? 'Please select month' : null,
                  items: [
                    'June',
                    'July',
                  ].map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectDepartment = value;
                  }),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      controller: startDateController,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        hintText: '06/02/2025',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101),
                              context: context,
                            );
                            setState(() {
                              if (picked != null) {
                                startDateController.text =
                                    DateFormat('dd/MM/yyyy').format(picked);
                                selectStartDate = picked.toString();
                              } else {
                                startDateController.text =
                                    startDateController.text;
                              }
                            });
                          },
                          icon: const Icon(IconlyLight.calendar, size: 22),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter birth date' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      controller: endDateController,
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        hintText: '07/02/2025',
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
                                endDateController.text =
                                    DateFormat('dd/MM/yyyy').format(picked);
                                selectEndDate = picked.toString();
                              } else {
                                endDateController.text = endDateController.text;
                              }
                            });
                          },
                          icon: const Icon(IconlyLight.calendar, size: 22),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter end date' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: leaveDurationController,
                    decoration: InputDecoration(
                      labelText: 'Leave Duration',
                      hintText: 'Enter leave duration',
                    ),
                  )),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: kNeutral800,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Status',
                          hintText: 'Select one',
                        ),
                        value: selectStatus,
                        validator: (value) =>
                            value == null ? 'Please select month' : null,
                        items: [
                          'Pending',
                          'Processing',
                          'Approved',
                        ].map((entry) {
                          return DropdownMenuItem(
                              value: entry, child: Text(entry));
                        }).toList(),
                        onChanged: (String? value) {
                          selectStatus = value;
                        }),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Note',
                  hintText: 'Enter Note',
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
                          startDateController.clear();
                          endDateController.clear();
                          leaveDurationController.clear();
                          noteController.clear();
                          selectEmployee = null;
                          selectDepartment = null;
                          selectLeaveType = null;
                          selectMonth = null;
                          selectStartDate = null;
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
}
