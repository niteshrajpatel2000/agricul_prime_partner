import 'package:flutter/material.dart';
import 'package:mobile_pos/Screens/hrm/widgets/label_style.dart';
import 'package:mobile_pos/constant.dart';

class AddNewDesignation extends StatefulWidget {
  const AddNewDesignation({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewDesignation> createState() => _AddNewDesignationState();
}

class _AddNewDesignationState extends State<AddNewDesignation> {
  final departmentNameController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedValue;
  GlobalKey<FormState> key = GlobalKey();

  @override
  void dispose() {
    departmentNameController.dispose();
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
          widget.isEdit == true ? 'Edit Designation' : 'Add New Designation',
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
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: departmentNameController,
                decoration: InputDecoration(
                  label: labelSpan(
                    title: 'Designation Name',
                    context: context,
                  ),
                  hintText: 'Enter Designation name',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter Designation Name' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: kNeutral800,
                ),
                decoration: InputDecoration(
                  labelText: 'Status',
                  hintText: 'Select a status',
                ),
                items: ['Active', 'InActive'].map((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a status' : null,
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
                          key.currentState?.reset();
                          departmentNameController.clear();
                          descriptionController.clear();
                          selectedValue = null;
                        });
                      },
                      child: Text('Reset'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
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
