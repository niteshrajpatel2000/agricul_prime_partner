import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/constant.dart';

import '../../Provider/profile_provider.dart';
import '../branch/model/branch_list_model.dart';
import '../branch/provider/branch_list_provider.dart';
import 'Model/user_role_model_new.dart';
import '../../service/check_user_role_permission_provider.dart';
import 'Provider/user_role_provider.dart';
import 'Repo/user_role_repo.dart';

class AddUserRoleScreen extends ConsumerStatefulWidget {
  const AddUserRoleScreen({
    super.key,
    this.userRole,
  });
  final UserRoleListModelNew? userRole;

  @override
  _AddUserRoleScreenState createState() => _AddUserRoleScreenState();
}

class _AddUserRoleScreenState extends ConsumerState<AddUserRoleScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool _selectAll = false;

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Map<String, Permission> selectedPermissions = {};

  @override
  void initState() {
    super.initState();
    if (widget.userRole != null) {
      emailController.text = widget.userRole!.email ?? '';
      titleController.text = widget.userRole!.name ?? '';
      phoneController.text = widget.userRole!.phone ?? '';
      // selectedBranch = widget.userRole.branchId ?? '';
      selectedPermissions = widget.userRole!.visibility.map((key, value) {
        return MapEntry(
            key,
            Permission(
              read: value['read'],
              create: value['create'],
              update: value['update'],
              delete: value['delete'],
              price: value['price'],
            ));
      });
    }
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  BranchData? selectedBranch;
  bool _branchInitialized = false;

  @override
  Widget build(BuildContext context) {
    final modules = _basePermissions.modules;
    final branchList = ref.watch(branchListProvider);
    final businessInfo = ref.watch(businessInfoProvider);
    final keys = modules.keys.toList(growable: false);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.userRole != null ? 'Update Role' : 'Add Role'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Color(0xFFE8E9F2),
            height: 1,
          ),
        ),
      ),
      body: businessInfo.when(data: (infoSnap) {
        return SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      if ((infoSnap.data?.addons?.multiBranchAddon == true) &&
                          (infoSnap.data?.enrolledPlan?.allowMultibranch == 1) &&
                          (infoSnap.data?.user?.activeBranch == null)) ...{
                        branchList.when(
                          data: (snapshot) {
                            if (widget.userRole != null && !_branchInitialized) {
                              final branchId = widget.userRole!.branchId;
                              try {
                                selectedBranch = snapshot.data!.firstWhere((branch) => branch.id == branchId);
                              } catch (e) {
                                selectedBranch = null;
                              }
                              _branchInitialized = true;
                            }

                            return DropdownButtonFormField<BranchData?>(
                              value: selectedBranch,
                              decoration: InputDecoration(
                                labelText: 'Branch',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              items: [
                                DropdownMenuItem<BranchData?>(
                                  value: null,
                                  child: Text(
                                    'All Branch',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: kTitleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                ...?snapshot.data?.map((branch) {
                                  return DropdownMenuItem<BranchData?>(
                                    value: branch,
                                    child: Text(
                                      branch.name ?? 'Unnamed',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: kTitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedBranch = value;
                                  print('---------------------------->${selectedBranch?.id ?? ''}');
                                });
                              },
                            );
                          },
                          error: (e, stack) => Center(child: Text(e.toString())),
                          loading: () => const Center(child: LinearProgressIndicator()),
                        ),
                        SizedBox(height: 24),
                      },
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name cannot be empty';
                          }
                          return null;
                        },
                        controller: titleController,
                        decoration: InputDecoration(
                          label:requiredLabel('Name'),
                          hintText: 'Enter user name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          label: requiredLabel('Phone'),
                          hintText: 'Enter phone number',
                          counterText: '',
                        ),
                        validator: (v) {
                          if (v == null || v.length != 10) {
                            return 'Enter valid 10 digit number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Email cannot be empty';
                        //   } else if (!value.contains('@')) {
                        //     return 'Please enter a valid email';
                        //   }
                        //   return null;
                        // },
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        // validator: (value) {
                        //   if (widget.userRole != null) {
                        //     return null;
                        //   }
                        //   if (value == null || value.isEmpty) {
                        //     return 'Password can\'t be empty';
                        //   } else if (value.length < 4) {
                        //     return 'Please enter a bigger password';
                        //   }
                        //
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Color(0xff7B7C84),
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Select All Checkbox
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: kMainColor,
                        side: BorderSide(color: Color(0xffA3A3A3)),
                        value: _selectAll,
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              _selectAll = value;
                              _toggleAllPermissions(value);
                            });
                          }
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Select All',
                          style: theme.textTheme.bodyMedium?.copyWith(color: kGreyTextColor, fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                _selectAll = !_selectAll;
                                _toggleAllPermissions(_selectAll);
                              });
                            },
                        ),
                      ),
                    ],
                  ),
                ),

                /// Permissions Table
                LayoutBuilder(
                  builder: (context, constraints) {
                    return FittedBox(
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Color(0xffF7F7F7)),
                        columnSpacing: 16,
                        border: const TableBorder(
                          verticalInside: BorderSide(color: Color(0xffE6E6E6)),
                        ),
                        columns: const [
                          DataColumn(label: Text('S.No.')),
                          DataColumn(label: Text('Feature')),
                          DataColumn(label: Text('Read')),
                          DataColumn(label: Text('Create')),
                          DataColumn(label: Text('Update')),
                          DataColumn(label: Text('Delete')),
                          DataColumn(label: Text('View Price')),
                        ],
                        rows: List<DataRow>.generate(keys.length, (index) {
                          final key = keys[index];
                          final perm = selectedPermissions[key] ?? modules[key];

                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(permissionDisplayTitles[key] ?? key)),
                            _buildCheckboxCell(
                              value: perm?.read,
                              onChanged: (v) => _togglePermission(key, 'read', v),
                            ),
                            _buildCheckboxCell(
                              value: perm?.create,
                              onChanged: (v) => _togglePermission(key, 'create', v),
                            ),
                            _buildCheckboxCell(
                              value: perm?.update,
                              onChanged: (v) => _togglePermission(key, 'update', v),
                            ),
                            _buildCheckboxCell(
                              value: perm?.delete,
                              onChanged: (v) => _togglePermission(key, 'delete', v),
                            ),
                            _buildCheckboxCell(
                              value: perm?.price,
                              onChanged: (v) => _togglePermission(key, 'price', v),
                            ),
                          ]);
                        }),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }, error: (e, stack) {
        return Text(e.toString());
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          // onPressed: _createUserRole,
          onPressed: () async {
            print('--------------------------->>>>${selectedBranch?.id}');
            if (validateAndSave()) {
              UserRoleRepo repo = UserRoleRepo();
              if (selectedPermissions.isEmpty) {
                selectedPermissions = _basePermissions.modules.map((key, perm) {
                  return MapEntry(
                      key,
                      Permission(
                        read: perm.read != null ? "0" : null,
                        create: perm.create != null ? "0" : null,
                        update: perm.update != null ? "0" : null,
                        delete: perm.delete != null ? "0" : null,
                        price: perm.price != null ? "0" : null,
                      ));
                });
              }

              final visibilityMap = selectedPermissions.map((key, perm) {
                final Map<String, String> permissionMap = {};
                if (perm.read != null) {
                  permissionMap["read"] = perm.read ?? "0";
                }
                if (perm.create != null) {
                  permissionMap["create"] = perm.create ?? "0";
                }
                if (perm.update != null) {
                  permissionMap["update"] = perm.update ?? "0";
                }
                if (perm.delete != null) {
                  permissionMap["delete"] = perm.delete ?? "0";
                }
                if (perm.price != null) {
                  permissionMap["price"] = perm.price ?? "0";
                }
                return MapEntry(key, permissionMap);
              });

              print('=========================${visibilityMap}');
              if (widget.userRole == null) {
                // Create
                await repo.addUser(
                  ref: ref,
                  context: context,
                  branchId: selectedBranch?.id.toString() ?? '',
                  name: titleController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  visibility: visibilityMap,
                  phone:phoneController.text,
                );
              } else {
                // Update

                await repo.updateUser(
                  ref: ref,
                  context: context,
                  userId: widget.userRole?.id.toString() ?? '',
                  branchId: selectedBranch?.id.toString() ?? '',
                  name: titleController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  visibility: visibilityMap,
                  phone:phoneController.text,
                );
              }

              ref.refresh(userRoleProvider);
              Navigator.pop(context);
            }
          },
          child: Text(widget.userRole != null ? 'update' : 'Create'),
        ),
      ),
    );
  }

  void _togglePermission(String key, String action, bool? value) {
    final basePerm = selectedPermissions[key] ?? _basePermissions.modules[key];
    if (basePerm == null) return;

    final updated = basePerm.copyWith(
      read: action == 'read' ? (value == true ? "1" : "0") : basePerm.read,
      create: action == 'create' ? (value == true ? "1" : "0") : basePerm.create,
      update: action == 'update' ? (value == true ? "1" : "0") : basePerm.update,
      delete: action == 'delete' ? (value == true ? "1" : "0") : basePerm.delete,
      price: action == 'price' ? (value == true ? "1" : "0") : basePerm.price,
    );
    setState(() {
      selectedPermissions[key] = updated;
    });
  }

  void _toggleAllPermissions(bool isSelected) {
    final updated = <String, Permission>{};

    _basePermissions.modules.forEach((key, perm) {
      updated[key] = Permission(
        read: perm.read != null ? (isSelected ? "1" : "0") : null,
        create: perm.create != null ? (isSelected ? "1" : "0") : null,
        update: perm.update != null ? (isSelected ? "1" : "0") : null,
        delete: perm.delete != null ? (isSelected ? "1" : "0") : null,
        price: perm.price != null ? (isSelected ? "1" : "0") : null,
      );
    });

    setState(() {
      selectedPermissions = updated;
    });
  }

  DataCell _buildCheckboxCell({
    required String? value,
    required ValueChanged<bool?> onChanged,
  }) {
    return DataCell(
      value == null
          ? const SizedBox.shrink()
          : Center(
              child: Checkbox(
                value: value == "1",
                onChanged: onChanged,
              ),
            ),
    );
  }
  Widget requiredLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  final _basePermissions = PermissionModules.fromJson({
    "dashboard": {"read": "0"},
    "sales": {
      "read": "0",
      "create": "0",
      "update": "0",
      "delete": "0",
    },
    "inventory": {
      "read": "0",
      "create": "0",
    },
    "sale-returns": {"read": "0", "create": "0", "price": "0"},
    "purchases": {"read": "0", "create": "0", "update": "0", "delete": "0", "price": "0"},
    "purchase-returns": {"read": "0", "create": "0", "price": "0"},
    "products": {"read": "0", "create": "0", "update": "0", "delete": "0", "price": "0"},
    // "branches": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "products-expired": {"read": "0"},
    "barcodes": {"read": "0", "create": "0"},
    "bulk-uploads": {"read": "0", "create": "0"},
    "categories": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "brands": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "units": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "product-models": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "stocks": {
      "read": "0",
      "price": "0",
    },
    "expired-products": {"read": "0"},
    "parties": {
      "read": "0",
      "create": "0",
      "update": "0",
      "delete": "0",
    },
    "incomes": {
      "read": "0",
      "create": "0",
      "update": "0",
      "delete": "0",
    },
    "income-categories": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "expenses": {
      "read": "0",
      "create": "0",
      "update": "0",
      "delete": "0",
    },
    "expense-categories": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "vats": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "dues": {"read": "0"},
    "subscriptions": {"read": "0"},
    "loss-profits": {"read": "0"},
    "payment-types": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "roles": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "department": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "designations": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "shifts": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "employees": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "leave-types": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "leaves": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "holidays": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "attendances": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "payrolls": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "attendance-reports": {"read": "0"},
    "payroll-reports": {"read": "0"},
    "leave-reports": {"read": "0"},
    "warehouses": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "transfers": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "racks": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "shelfs": {"read": "0", "create": "0", "update": "0", "delete": "0"},
    "manage-settings": {"read": "0", "update": "0"},
    "download-apk": {"read": "0"},
    "sale-reports": {"read": "0"},
    "sale-return-reports": {"read": "0"},
    "purchase-reports": {"read": "0"},
    "purchase-return-reports": {"read": "0"},
    "vat-reports": {"read": "0"},
    "income-reports": {"read": "0"},
    "expense-reports": {"read": "0"},
    "loss-profits-details": {"read": "0"},
    "stock-reports": {"read": "0"},
    "due-reports": {"read": "0"},
    "supplier-due-reports": {"read": "0"},
    "loss-profit-reports": {"read": "0"},
    "transaction-history-reports": {"read": "0"},
    "subscription-reports": {"read": "0"},
    "expired-product-reports": {"read": "0"},
  });
  final Map<String, String> permissionDisplayTitles = {
    "dashboard": "Dashboard",
    "sales": "Sales",
    "inventory": "Inventory",
    "sale-returns": "Sale Returns",
    "purchases": "Purchases",
    "purchase-returns": "Purchase Returns",
    "products": "Products",
    // "branches": "Branches",
    "products-expired": "Expired Products",
    "barcodes": "Barcodes",
    "bulk-uploads": "Bulk Uploads",
    "categories": "Categories",
    "brands": "Brands",
    "units": "Units",
    "product-models": "Product Models",
    "stocks": "Stocks",
    "expired-products": "Expired Products",
    "parties": "Parties",
    "incomes": "Incomes",
    "income-categories": "Income Categories",
    "expenses": "Expenses",
    "expense-categories": "Expense Categories",
    "vats": "VATs",
    "dues": "Dues",
    "subscriptions": "Subscriptions",
    "loss-profits": "Loss & Profits",
    "payment-types": "Payment Types",
    "roles": "Roles",
    "department": "Departments",
    "designations": "Designations",
    "shifts": "Shifts",
    "employees": "Employees",
    "leave-types": "Leave Types",
    "leaves": "Leaves",
    "holidays": "Holidays",
    "attendances": "Attendances",
    "payrolls": "Payrolls",
    "attendance-reports": "Attendance Reports",
    "payroll-reports": "Payroll Reports",
    "leave-reports": "Leave Reports",
    "warehouses": "Warehouses",
    "transfers": "Transfers",
    "racks": "Racks",
    "shelfs": "Shelves",
    "manage-settings": "Manage Settings",
    "download-apk": "Download APK",
    "sale-reports": "Sale Reports",
    "sale-return-reports": "Sale Return Reports",
    "purchase-reports": "Purchase Reports",
    "purchase-return-reports": "Purchase Return Reports",
    "vat-reports": "VAT Reports",
    "income-reports": "Income Reports",
    "expense-reports": "Expense Reports",
    "loss-profits-details": "Loss & Profit Details",
    "stock-reports": "Stock Reports",
    "due-reports": "Due Reports",
    "supplier-due-reports": "Supplier Due Reports",
    "loss-profit-reports": "Loss & Profit Reports",
    "transaction-history-reports": "Transaction History Reports",
    "subscription-reports": "Subscription Reports",
    "expired-product-reports": "Expired Product Reports",
  };
}

class Permission {
  final String? read;
  final String? create;
  final String? update;
  final String? delete;
  final String? price;

  const Permission({
    this.read,
    this.create,
    this.update,
    this.delete,
    this.price,
  });

  Permission copyWith({
    String? read,
    String? create,
    String? update,
    String? delete,
    String? price,
  }) {
    return Permission(
      read: read ?? this.read,
      create: create ?? this.create,
      update: update ?? this.update,
      delete: delete ?? this.delete,
      price: price ?? this.price,
    );
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      read: json['read'] as String?,
      create: json['create'] as String?,
      update: json['update'] as String?,
      delete: json['delete'] as String?,
      price: json['price'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (read != null) 'read': read,
      if (create != null) 'create': create,
      if (update != null) 'update': update,
      if (delete != null) 'delete': delete,
      if (price != null) 'price': price,
    };
  }
}

class PermissionModules {
  final Map<String, Permission> modules;

  PermissionModules(this.modules);

  factory PermissionModules.fromJson(Map<String, dynamic> json) {
    return PermissionModules(
      json.map((key, value) => MapEntry(key, Permission.fromJson(value))),
    );
  }
}
