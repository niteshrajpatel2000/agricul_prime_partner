import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';
import '../widgets/set_time.dart';

class AddNewAttendance extends StatefulWidget {
  const AddNewAttendance({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewAttendance> createState() => _AddNewAttendanceState();
}

class _AddNewAttendanceState extends State<AddNewAttendance> {
  String? selectEmployee;
  String? selectedShift;
  String? selectedMonth;
  String? selectedDate;
  final GlobalKey<FormState> _key = GlobalKey();
  final dateController = TextEditingController();
  final timeInController = TextEditingController();
  final timeOutController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void dispose() {
    dateController.clear();
    timeOutController.clear();
    timeInController.clear();
    noteController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEdit == true ? 'Edit Attendance' : 'Add New Attendance',
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
                    return DropdownMenuItem(value: entry, child: Text(entry));
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
                    labelText: 'Shift',
                    hintText: 'Select Shift',
                  ),
                  value: selectedShift,
                  validator: (value) =>
                      value == null ? 'Please select shift' : null,
                  items: [
                    'Morning',
                    'Day',
                  ].map((entry) {
                    return DropdownMenuItem(value: entry, child: Text(entry));
                  }).toList(),
                  onChanged: (String? value) {
                    selectedShift = value;
                  }),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: kNeutral800,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Month',
                          hintText: 'Select one',
                        ),
                        value: selectedMonth,
                        validator: (value) =>
                            value == null ? 'Please select a month' : null,
                        items: [
                          'June',
                          'July',
                        ].map((entry) {
                          return DropdownMenuItem(
                              value: entry, child: Text(entry));
                        }).toList(),
                        onChanged: (String? value) {
                          selectedMonth = value;
                        }),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      controller: dateController,
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
                                dateController.text =
                                    DateFormat('dd/MM/yyyy').format(picked);
                                selectedDate = picked.toString();
                              } else {
                                dateController.text = dateController.text;
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
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        setTime(timeInController, context);
                      },
                      readOnly: true,
                      controller: timeInController,
                      decoration: InputDecoration(
                        labelText: 'Time In',
                        hintText: '09:10 AM',
                        suffixIcon: HugeIcon(
                            icon: HugeIcons.strokeRoundedClock01,
                            size: 18,
                            color: kNeutral800),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please Select Time In' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: timeOutController,
                      onTap: () => setTime(timeOutController, context),
                      decoration: InputDecoration(
                        labelText: 'Time Out',
                        hintText: '05:50 PM',
                        suffixIcon: HugeIcon(
                            icon: HugeIcons.strokeRoundedClock01,
                            size: 18,
                            color: kNeutral800),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please Select Time Out' : null,
                    ),
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
                          dateController.clear();
                          timeInController.clear();
                          timeOutController.clear();
                          noteController.clear();
                          selectEmployee = null;
                          selectedShift = null;
                          selectedMonth = null;
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
