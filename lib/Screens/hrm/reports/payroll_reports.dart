import 'package:flutter/material.dart';
import 'package:mobile_pos/Screens/hrm/widgets/filter_dropdown.dart';
import 'package:mobile_pos/Screens/hrm/widgets/model_bottom_sheet.dart';
import 'package:mobile_pos/constant.dart';

class PayrollReports extends StatefulWidget {
  const PayrollReports({super.key});

  @override
  State<PayrollReports> createState() => _PayrollReportsState();
}

class _PayrollReportsState extends State<PayrollReports> {
  final List<Map<String, String>> _shifts = [
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
    },
    {
      "name": "Shaidul Islam",
      "date": "31 May, 2025",
      "amount": "\$50,000",
      "paymentType": "Bank",
      "status": "Paid",
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
        title: Text('Payroll List'),
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
                          value: selectedTime ?? 'June',
                          items: ['June', 'July', 'August'].map((entry) {
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
          payroll: _shifts[index],
        ),
      ),
    );
  }

  Widget _buildShiftItem({
    required BuildContext context,
    required Map<String, String> payroll,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => viewModalSheet(
        context: context,
        item: {
          "Employee": "Md Sahidul islam",
          "Payment Year": "2025",
          "Month": "June",
          "Date": "07/02/2025",
          "Amount": "\$5000",
          "Payment Type": "Bank",
        },
        descriptionTitle: 'Note : ',
        description: 'N/A',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payroll['name'] ?? 'n/a',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  payroll['date'] ?? 'n/a',
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: kNeutral800),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeColumn(
                  time: payroll['amount'] ?? 'n/a',
                  label: 'Amount',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: payroll['paymentType'] ?? 'n/a',
                  label: 'Payment',
                  theme: theme,
                ),
                _buildTimeColumn(
                  time: payroll['status'] ?? 'n/a',
                  label: 'Status',
                  titleColor: kSuccessColor,
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
    Color? titleColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: titleColor ?? kTitleColor,
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
