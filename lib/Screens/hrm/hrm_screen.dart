import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_pos/Screens/hrm/attendance/attendance_screen.dart';
import 'package:mobile_pos/Screens/hrm/department/department_screen.dart';
import 'package:mobile_pos/Screens/hrm/designation/designation_list.dart';
import 'package:mobile_pos/Screens/hrm/employee/employee_list_screen.dart';
import 'package:mobile_pos/Screens/hrm/holiday/holiday_list_screen.dart';
import 'package:mobile_pos/Screens/hrm/leave_request/leave/leave_list_screen.dart';
import 'package:mobile_pos/Screens/hrm/leave_request/leave_type/leave_type_list.dart';
import 'package:mobile_pos/Screens/hrm/payroll/payroll_list.dart';
import 'package:mobile_pos/Screens/hrm/reports/attandence_report.dart';
import 'package:mobile_pos/Screens/hrm/reports/leave_reports.dart';
import 'package:mobile_pos/Screens/hrm/reports/payroll_reports.dart';
import 'package:mobile_pos/Screens/hrm/shift/shift_screen.dart';

import '../../constant.dart';

class HrmScreen extends StatefulWidget {
  const HrmScreen({super.key});

  @override
  State<HrmScreen> createState() => _HrmScreenState();
}

class _HrmScreenState extends State<HrmScreen> {
  String? selectedTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text("HRM"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //---------------Department--------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/depertment.svg',
              title: "Department",
              destination: DepartmentScreen(),
            ),
            const SizedBox(height: 10),
            //-----------------Designation----------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/designation.svg',
              title: "Designation",
              destination: DesingnationList(),
            ),
            const SizedBox(height: 10),
            //---------------------Shift----------------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/shift.svg',
              title: "Shift",
              destination: const ShiftScreen(),
            ),
            SizedBox(height: 10),
            //-----------------Employee---------------------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/employee.svg',
              title: "Employee",
              destination: const EmployeeListScreen(),
            ),
            SizedBox(height: 10),
            //-----------------Leave request-----------------------------
            _buildExpansionTile(
              context,
              icon: 'assets/hrm/leave.svg',
              title: 'Leave Request',
              children: [
                _buildSubMenuItem(
                  context,
                  title: 'Leave Type',
                  destination: const LeaveTypeList(),
                ),
                _buildSubMenuItem(
                  context,
                  title: 'Leave',
                  destination: const LeaveListScreen(),
                ),
              ],
            ),
            SizedBox(height: 10),
            //------------------------Holiday----------------------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/holiday.svg',
              title: "Holiday",
              destination: const HolidayList(),
            ),
            SizedBox(height: 10),
            //------------------------Attendance-------------------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/attendence.svg',
              title: "Attendance",
              destination: const AttendanceScreen(),
            ),
            SizedBox(height: 10),
            //-------------------------payroll----------------------------------
            _buildListItem(
              context,
              icon: 'assets/hrm/payroll.svg',
              title: "Payroll",
              destination: const PayrollScreen(),
            ),
            SizedBox(height: 10),
            //--------------------------Reports--------------------------------
            _buildExpansionTile(
              context,
              icon: 'assets/hrm/reports.svg',
              title: 'Reports',
              children: [
                _buildSubMenuItem(
                  context,
                  title: 'Attendance',
                  destination: const AttendanceReports(),
                ),
                _buildSubMenuItem(
                  context,
                  title: 'Payroll',
                  destination: const PayrollReports(),
                ),
                _buildSubMenuItem(
                  context,
                  title: 'Leave',
                  destination: const LeaveReports(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///-------------build menu item------------------------------
  Widget _buildListItem(
    BuildContext context, {
    required String icon,
    required String title,
    required Widget destination,
  }) {
    final _theme = Theme.of(context);
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(6)),
      horizontalTitleGap: 15,
      contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => destination)),
      leading: SvgPicture.asset(
        icon,
        height: 40,
        width: 40,
      ),
      title: Text(
        title,
        style: _theme.textTheme.bodyLarge,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: kNeutral800,
      ),
    );
  }

  ///---------------------expansion tile item---------------------------------
  Widget _buildExpansionTile(
    BuildContext context, {
    required String icon,
    required String title,
    required List<Widget> children,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: WidgetStateColor.transparent,
      ),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        iconColor: kNeutral800,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 50),
        leading: SvgPicture.asset(
          icon,
          height: 40,
          width: 40,
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        children: children,
      ),
    );
  }

  ///-------------------sub menu item---------------------------------------
  Widget _buildSubMenuItem(
    BuildContext context, {
    required String title,
    required Widget destination,
  }) {
    return ListTile(
      onTap: () {
        setState(() => selectedTitle = title);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destination));
      },
      visualDensity: const VisualDensity(vertical: -4),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: selectedTitle == title ? Colors.red : kTitleColor,
            ),
      ),
    );
  }
}
