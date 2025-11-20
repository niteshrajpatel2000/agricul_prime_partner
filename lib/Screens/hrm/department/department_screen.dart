import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/department/add_new_depertment.dart';
import 'package:mobile_pos/Screens/hrm/widgets/deleteing_alart_dialog.dart';
import 'package:mobile_pos/Screens/hrm/widgets/global_search_appbar.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
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
        title: 'Department',
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
                    "Department": "Information Technology",
                    "Status": "Active",
                  },
                  description:
                      "Manages all technology-related systems and services in a business. It ensures smooth operation, security, and development of digital tools and networks.",
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
                      items[index]['department'] ?? 'n/a',
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
                          builder: (context) => AddNewDepartment(
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
                      itemName: 'Department',
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
                MaterialPageRoute(builder: (context) => AddNewDepartment()));
          },
          label: Text('Add Department'),
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
      "department": "Sales & Marketing",
      "description": "Oversees the entire Business."
    },
    {
      "department": "Finance & Accounting",
    },
    {
      "department": "Human Resources",
    },
    {
      "department": "Procurement & Supply Chain",
    },
    {
      "department": "Information Technology",
      "description": "Manages all technology-related systems and services",
    },
    {
      "department": "Customer Service & Support",
    },
    {
      "department": "Legal & Compliance",
    },
    {
      "department": "Security & Facility",
    },
    {
      "department": "Butcher",
      "description":
          "Cuts and prepares meat for sale according to customer preferences",
    },
    {
      "department": "Cashier",
    },
  ];
}
