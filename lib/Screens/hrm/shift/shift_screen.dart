import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/shift/add_new_shift.dart';
import 'package:mobile_pos/Screens/hrm/widgets/global_search_appbar.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

import '../widgets/deleteing_alart_dialog.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  bool _isSearch = false;
  final _searchController = TextEditingController();
  final List<Map<String, String>> _shifts = [
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
    {
      "shift": "Day",
      "startTime": "09:00 AM",
      "endTime": "05:00 PM",
      "breakStart": "03:10 PM",
      "breakEnd": "03:50 PM",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalSearchAppBar(
        isSearch: _isSearch,
        onSearchToggle: () => setState(() => _isSearch = !_isSearch),
        title: 'Shift',
        controller: _searchController,
        onChanged: (query) {
          // Handle search query changes
        },
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _shifts.length,
        separatorBuilder: (_, __) => const Divider(
          color: kBackgroundColor,
          height: 2,
        ),
        itemBuilder: (_, index) => _buildShiftItem(
          context: context,
          shift: _shifts[index],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewShift()),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Shift'), // Changed from 'Add Department'
        ),
      ),
    );
  }

  Widget _buildShiftItem({
    required BuildContext context,
    required Map<String, String> shift,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => viewModalSheet(context: context, item: {
        "Shift": "Day",
        "Start Time": "09:00 AM",
        "End Time": "05:00 PM",
        "Break Time": "03:10 PM - 03:50PM",
        "Break Duration": "40 min",
        "Status": "Active",
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shift['shift'] ?? 'n/a',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'Break Time: ',
                style: const TextStyle(color: kNeutral800),
                children: [
                  TextSpan(
                      text:
                          '${shift['breakStart'] ?? 'n/a'} - ${shift['breakEnd'] ?? 'n/a'}',
                      style: TextStyle(color: kTitleColor)),
                ],
              ),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeColumn(
                  time: shift['startTime'] ?? 'n/a',
                  label: 'Start Time',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: shift['endTime'] ?? 'n/a',
                  label: 'End Time',
                  theme: theme,
                ),
                _buildActionButtons(context),
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
        SizedBox(height: 8),
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
              builder: (context) => const AddNewShift(isEdit: true),
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
            itemName: 'Shift',
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
