import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/attendance/add_new_attendance.dart';
import 'package:mobile_pos/Screens/hrm/widgets/filter_dropdown.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

import '../widgets/deleteing_alart_dialog.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, String>> _shifts = [
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
    {
      "name": "Shaidul Islam",
      "date": "24 Jun 2025",
      "timeIn": "09:00 AM",
      "timeOut": "05:00 PM",
      "duration": "09:00 hrs",
    },
  ];
  String? selectedEmployee;
  String? selectedTime;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Attendance'),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: Column(
              children: [
                Divider(
                  thickness: 1.5,
                  color: kBackgroundColor,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 13),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: FilterDropdownButton(
                          value: selectedEmployee ??
                              'All Employee', // Use the selected value or default
                          items: ['All Employee', 'Sales & Marketing']
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry,
                              child: Text(
                                entry,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: kNeutral800,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedEmployee = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: FilterDropdownButton(
                          buttonDecoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadiusGeometry.circular(5),
                            border: Border.all(
                              color: kBorderColor,
                            ),
                          ),
                          value: selectedTime ?? 'Today',
                          items: ['Today', 'Weekly', 'Monthly', 'Yearly']
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry,
                              child: Text(
                                entry,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: kNeutral800,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedTime = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: kBackgroundColor,
                  height: 1,
                ),
              ],
            )),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _shifts.length,
        separatorBuilder: (_, __) => const Divider(
          color: kBackgroundColor,
          height: 1.5,
        ),
        itemBuilder: (_, index) => _buildShiftItem(
          context: context,
          attendance: _shifts[index],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewAttendance()),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Attendance'), // Changed from 'Add Department'
        ),
      ),
    );
  }

  Widget _buildShiftItem({
    required BuildContext context,
    required Map<String, String> attendance,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => viewModalSheet(
        context: context,
        item: {
          "Employee": "Md Sahidul islam",
          "Shift": "Morning",
          "Month": "June",
          "Date": "06/02/2025",
          "Time In": "09:10 AM",
          "Time Out": "05:50 PM",
        },
        description: 'N/A',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attendance['name'] ?? 'n/a',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      attendance['date'] ?? 'n/a',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: kNeutral800),
                    ),
                  ],
                ),
                _buildActionButtons(context),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeColumn(
                  time: attendance['timeIn'] ?? 'n/a',
                  label: 'Time In',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: attendance['timeOut'] ?? 'n/a',
                  label: 'Time Out',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: attendance['duration'] ?? 'n/a',
                  label: 'Duration',
                  theme: theme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn({
    required String time,
    required String label,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: kNeutral800,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewAttendance(isEdit: true),
            ),
          ),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedPencilEdit02,
            color: kSuccessColor,
            size: 20,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => showDeleteConfirmationDialog(
            context: context,
            itemName: 'Attendance',
          ),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedDelete03,
            color: Colors.red,
            size: 20,
          ),
        ),
      ],
    );
  }
}
