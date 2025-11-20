import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class AddNewHoliday extends StatefulWidget {
  const AddNewHoliday({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewHoliday> createState() => _AddNewHolidayState();
}

class _AddNewHolidayState extends State<AddNewHoliday> {
  final nameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? selectStartDate;
  String? selectEndDate;
  @override
  void dispose() {
    nameController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEdit == true ? 'Edit Holiday' : 'Add New Holiday',
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
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter holiday name',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please Enter Holiday Name' : null,
                ),
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
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
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
                            value!.isEmpty ? "Please Select Start Date" : null,
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
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
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
                                  endDateController.text =
                                      endDateController.text;
                                }
                              });
                            },
                            icon: const Icon(IconlyLight.calendar, size: 22),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please Select Start Date" : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description ',
                    hintText: 'Enter Description...',
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
                            descriptionController.clear();
                            startDateController.clear();
                            endDateController.clear();
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
                        child: Text(
                          widget.isEdit == true ? 'Update' : 'Save',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
