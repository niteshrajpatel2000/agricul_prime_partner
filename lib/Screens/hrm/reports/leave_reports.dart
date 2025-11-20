import 'package:flutter/material.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

class LeaveReports extends StatefulWidget {
  const LeaveReports({super.key});

  @override
  State<LeaveReports> createState() => _LeaveReportsState();
}

class _LeaveReportsState extends State<LeaveReports> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Leave Reports '),
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
}
