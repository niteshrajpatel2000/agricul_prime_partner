import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/leave_request/leave/add_new_leave.dart';
import 'package:mobile_pos/Screens/hrm/widgets/filter_dropdown.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

import '../../widgets/deleteing_alart_dialog.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({super.key});

  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> {
  final List<Map<String, String>> _shifts = [
    {
      "name": "Shaidul Islam",
      "leaveType": "Sick Leave",
      "month": "June",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Leslie Alexander",
      "leaveType": "Sick Leave",
      "month": "June",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Savannah Nguyen",
      "leaveType": "Sick Leave",
      "month": "June",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Guy Hawkins",
      "leaveType": "Sick Leave",
      "month": "June",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Annette Black",
      "leaveType": "Sick Leave",
      "month": "June",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Savannah Nguyen",
      "leaveType": "Sick Leave",
      "month": "June",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
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
        title: Text('Leave List'),
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
                          items: [
                            'All Employee',
                            'Sales & Marketing',
                          ].map((entry) {
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
                          value: selectedTime ?? 'June',
                          items: [
                            'June',
                            'July',
                          ].map((entry) {
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
          leave: _shifts[index],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewLeave()),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Add Leave',
          ), // Changed from 'Add Department'
        ),
      ),
    );
  }

  Widget _buildShiftItem({
    required BuildContext context,
    required Map<String, String> leave,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => viewModalSheet(
        context: context,
        item: {
          "Name": leave['name'] ?? 'n/a',
          "Department": "Manager",
          "Leave Type": "Sick Leave",
          "Month": "June",
          "Start Date": "06/02/2025",
          "End Date": "07/02/2025",
          "Leave Duration": "1",
          "status": "Pending"
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
                      leave['name'] ?? 'n/a',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      leave['leaveType'] ?? 'n/a',
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
                  time: leave['month'] ?? 'n/a',
                  label: 'Month',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: leave['startDate'] ?? 'n/a',
                  label: 'Start Date',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: leave['endDate'] ?? 'n/a',
                  label: 'End Date',
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
              builder: (context) => const AddNewLeave(isEdit: true),
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
            itemName: 'Leave',
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
