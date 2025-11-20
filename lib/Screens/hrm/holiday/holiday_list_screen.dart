import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/holiday/add_new_holiday.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

import '../widgets/deleteing_alart_dialog.dart';
import '../widgets/global_search_appbar.dart';

class HolidayList extends StatefulWidget {
  const HolidayList({super.key});

  @override
  State<HolidayList> createState() => _HolidayListState();
}

class _HolidayListState extends State<HolidayList> {
  final List<Map<String, String>> _shifts = [
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
    {
      "name": "Independence Day",
      "startDate": "02 Jun, 2025",
      "endDate": "04 Jun, 2025",
    },
  ];
  bool _isSearch = false;
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalSearchAppBar(
        isSearch: _isSearch,
        onSearchToggle: () => setState(
          () => _isSearch = !_isSearch,
        ),
        title: 'Holiday List',
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
          height: 1.5,
        ),
        itemBuilder: (_, index) => _buildShiftItem(
          context: context,
          holiday: _shifts[index],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewHoliday(),
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Holiday'), // Changed from 'Add Department'
        ),
      ),
    );
  }

  Widget _buildShiftItem({
    required BuildContext context,
    required Map<String, String> holiday,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => viewModalSheet(
        context: context,
        item: {
          "Name": "Independence Day",
          "Start Date": "06/02/2025 ",
          "End Date": "07/02/2025 "
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
                Text(
                  holiday['name'] ?? 'n/a',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                _buildActionButtons(context),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeColumn(
                  time: holiday['startDate'] ?? 'n/a',
                  label: 'Start Date',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: holiday['endDate'] ?? 'n/a',
                  label: 'End Date',
                  theme: theme,
                ),
                SizedBox.shrink(),
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
              builder: (context) => const AddNewHoliday(isEdit: true),
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
