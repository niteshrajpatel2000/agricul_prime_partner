import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/leave_request/leave_type/add_new_leave_type.dart';
import 'package:mobile_pos/Screens/hrm/widgets/deleteing_alart_dialog.dart';
import 'package:mobile_pos/Screens/hrm/widgets/global_search_appbar.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

class LeaveTypeList extends StatefulWidget {
  const LeaveTypeList({super.key});

  @override
  State<LeaveTypeList> createState() => _LeaveTypeListState();
}

class _LeaveTypeListState extends State<LeaveTypeList> {
  bool _isSearch = false;
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: kWhite,
      appBar: GlobalSearchAppBar(
        isSearch: _isSearch,
        onSearchToggle: () => setState(() => _isSearch = !_isSearch),
        title: 'Leave Type',
        controller: _searchController,
        onChanged: (query) {
          // Handle search query changes
        },
      ),
      body: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () {
                viewModalSheet(
                  context: context,
                  item: {
                    "Name": "Sick Leave",
                    "Status": "Active",
                  },
                  description: "N/A",
                );
              },
              contentPadding: EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      items[index]['name'] ?? 'n/a',
                      style: _theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.all(0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewLeaveType(
                            isEdit: true,
                          ),
                        ),
                      );
                    },
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedPencilEdit02,
                      color: kSuccessColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    items[index]['description'] ?? 'n/a',
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      color: kNeutral800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.all(0),
                      ),
                    ),
                    visualDensity: VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    onPressed: () => showDeleteConfirmationDialog(
                      context: context,
                      itemName: 'Leave Type',
                    ),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedDelete03,
                      color: Colors.red,
                      size: 20,
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(
                color: kBackgroundColor,
                height: 2,
              ),
          itemCount: items.length),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewLeaveType()));
          },
          label: Text('Add Leave Type'),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> items = [
    {
      "name": "Sick Leave",
      "description": "For health-related absences",
    },
    {
      "name": "Casual Leave",
    },
    {
      "name": "Paid Leave",
    },
    {
      "name": "Unpaid Leave",
    },
    {
      "name": "Maternity Leave",
      "description": "Manages all technology-related systems and services",
    },
    {
      "name": "Annual Leave",
    },
    {
      "name": "Sick Leave",
      "description": "For health-related absences",
    },
    {
      "name": "Casual Leave",
    },
    {
      "name": "Paid Leave",
    },
    {
      "name": "Unpaid Leave",
    },
  ];
}
