import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class AddNewPayroll extends StatefulWidget {
  const AddNewPayroll({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewPayroll> createState() => _AddNewPayrollState();
}

class _AddNewPayrollState extends State<AddNewPayroll> {
  String? selectEmployee;
  String? selectYear;
  String? selectedMonth;
  String? selectDate;
  String? selectPaymentType;
  final GlobalKey<FormState> _key = GlobalKey();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    amountController.dispose();
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
          widget.isEdit == true ? 'Edit Payroll' : 'Add New Payroll',
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
                    labelText: 'Payment Year',
                    hintText: 'Select one',
                  ),
                  value: selectYear,
                  validator: (value) =>
                      value == null ? 'Please select payment year' : null,
                  items: [
                    '2024',
                    '2025',
                    '2026',
                  ].map((entry) {
                    return DropdownMenuItem(value: entry, child: Text(entry));
                  }).toList(),
                  onChanged: (String? value) {
                    selectYear = value;
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
                        labelText: 'Date',
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
                                selectDate = picked.toString();
                              } else {
                                dateController.text = dateController.text;
                              }
                            });
                          },
                          icon: const Icon(IconlyLight.calendar, size: 22),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter date' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Ex: \$50000',
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your amount' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: kNeutral800,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Payment Type',
                          hintText: 'Select one',
                        ),
                        value: selectPaymentType,
                        validator: (value) =>
                            value == null ? 'Please select payment type' : null,
                        items: [
                          'Bank',
                          'Card',
                        ].map((entry) {
                          return DropdownMenuItem(
                              value: entry, child: Text(entry));
                        }).toList(),
                        onChanged: (String? value) {
                          selectedMonth = value;
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
                          dateController.clear();
                          amountController.clear();
                          noteController.clear();
                          selectEmployee = null;
                          selectYear = null;
                          selectPaymentType = null;
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
