import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile_pos/Screens/hrm/employee/add_new_employee.dart';
import 'package:mobile_pos/Screens/hrm/widgets/deleteing_alart_dialog.dart';
import 'package:mobile_pos/Screens/hrm/widgets/global_search_appbar.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
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
        title: 'Employee',
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
                  showImage: true,
                  image: employeeList[index]['image'],
                  item: {
                    "Full Name": "Md Sahidul islam",
                    "Designation ": "Sales & Marketing",
                    "Department ": "Manager",
                    "Email ": "shaidul@gmail.com",
                    "Phone ": "01865245984",
                    "Country": "Bangladesh",
                    "Salary": "\$5000",
                    "Gender": "Male",
                    "Shift": "Day",
                    "Birth Date": "06/02/1998",
                    "Join Date": "06/02/2025",
                    "Status": "Active",
                  },
                );
              },
              contentPadding: EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              horizontalTitleGap: 14,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              leading: Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kMainColor.withValues(alpha: 0.1)),
                child: employeeList[index]['image'] == null
                    ? Text(
                        employeeList[index]['name']!.substring(0, 1),
                        style: _theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: kMainColor,
                        ),
                      )
                    : Image.network(
                        fit: BoxFit.cover,
                        employeeList[index]['image'] ??
                            'https://picsum.photos/400/400?seed=50'),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      employeeList[index]['name'] ?? 'n/a',
                      style: _theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: IconButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.zero,
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
                            builder: (context) => AddNewEmployee(
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
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    employeeList[index]['phone'] ?? 'n/a',
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      color: kNeutral800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.zero,
                        ),
                      ),
                      visualDensity: VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      onPressed: () => showDeleteConfirmationDialog(
                        context: context,
                        itemName: 'Employee',
                      ),
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedDelete03,
                        color: Colors.red,
                        size: 20,
                      ),
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
          itemCount: employeeList.length),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewEmployee()));
          },
          label: Text('Add Employee'),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> employeeList = [
    {
      "name": "Arlene McCoy",
      "phone": "01763521458",
    },
    {
      "name": "Savannah Nguyen",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=5",
      "name": "Savannah Nguyen",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=45",
      "name": "Jerome Bell",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=7",
      "name": "Dianne Russell",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=14",
      "name": "Cody Fisher",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=15",
      "name": "Kristin Watson",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=18",
      "name": "Kathryn Murphy",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=20",
      "name": "Marvin McKinney",
      "phone": "01763521458",
    },
    {
      "image": "https://picsum.photos/400/400?seed=28",
      "name": "Jacob Jones",
      "phone": "01763521458",
    },
  ];
}
