import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../constant.dart';
import '../widgets/set_time.dart';

class AddNewShift extends StatefulWidget {
  const AddNewShift({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddNewShift> createState() => _AddNewShiftState();
}

class _AddNewShiftState extends State<AddNewShift> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? selectedShift;
  String? selectedBreakStatus;
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final startBreakTimeController = TextEditingController();
  final endBreakTimeController = TextEditingController();

  @override
  void dispose() {
    startTimeController.dispose();
    endTimeController.dispose();
    startBreakTimeController.dispose();
    endBreakTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEdit == true ? 'Edit Shift' : 'Add New Shift',
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
                    labelText: 'Shift Name',
                    hintText: 'Select one',
                  ),
                  items: ['Day', 'Night'].map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedShift = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a status' : null,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: kNeutral800,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Break Status',
                    hintText: 'Select one',
                  ),
                  items: ['Yes', 'No'].map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBreakStatus = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a status' : null,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          setTime(startTimeController, context);
                        },
                        readOnly: true,
                        controller: startTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          hintText: '03:10 PM',
                          suffixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedClock01,
                              size: 18,
                              color: kNeutral800),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please Select Start Time' : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: endTimeController,
                        onTap: () => setTime(endTimeController, context),
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          hintText: '03:50 PM',
                          suffixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedClock01,
                              size: 18,
                              color: kNeutral800),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please Select End Time' : null,
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
                          setTime(startBreakTimeController, context);
                        },
                        readOnly: true,
                        controller: startBreakTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Break Time',
                          hintText: '03:10 PM',
                          suffixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedClock01,
                              size: 18,
                              color: kNeutral800),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please Select Start Break Time'
                            : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: endBreakTimeController,
                        onTap: () => setTime(endBreakTimeController, context),
                        decoration: InputDecoration(
                          labelText: 'End Break Time',
                          hintText: '03:50 PM',
                          suffixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedClock01,
                              size: 18,
                              color: kNeutral800),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please Select End Break Time'
                            : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _key.currentState?.reset();
                            startTimeController.clear();
                            endTimeController.clear();
                            startBreakTimeController.clear();
                            endBreakTimeController.clear();
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
            )),
      ),
    );
  }
}
