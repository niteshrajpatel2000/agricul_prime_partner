import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../GlobalComponents/glonal_popup.dart';
import '../../constant.dart';
import '../../service/check_user_role_permission_provider.dart';
import 'Repo/branch_repo.dart';
import 'model/branch_list_model.dart';

class AddAndEditBranch extends StatefulWidget {
  final BranchData? branchData;

  const AddAndEditBranch({super.key, this.branchData});

  @override
  _AddAndEditBranchState createState() => _AddAndEditBranchState();
}

class _AddAndEditBranchState extends State<AddAndEditBranch> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final openingBalanceController = TextEditingController();
  final descriptionController = TextEditingController();

  bool get isEdit => widget.branchData != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      nameController.text = widget.branchData?.name ?? '';
      phoneController.text = widget.branchData?.phone ?? '';
      emailController.text = widget.branchData?.email ?? '';
      addressController.text = widget.branchData?.address ?? '';
      openingBalanceController.text = widget.branchData?.branchOpeningBalance?.toString() ?? '';
      descriptionController.text = widget.branchData?.description ?? '';
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void resetForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    openingBalanceController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final permissionService = PermissionService(ref);
      return GlobalPopup(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(isEdit ? 'Update Branch' : 'Create Branch'),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10, top: 20, bottom: 10),
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (v) => v!.isEmpty ? 'Please enter branch name' : null,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                    ),

                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'Phone',
                        hintText: 'Enter Phone',
                      ),
                    ),

                    TextFormField(
                      controller: emailController,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                      ),
                    ),

                    TextFormField(
                      controller: addressController,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'Address',
                        hintText: 'Enter Address',
                      ),
                    ),

                    TextFormField(
                      controller: openingBalanceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: kInputDecoration.copyWith(
                        labelText: 'Opening Balance',
                        hintText: 'Enter Balance',
                      ),
                    ),

                    TextFormField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'Description',
                        hintText: 'Enter Description',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                    ),

                    /// Buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: resetForm,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: kMainColor),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: const Text('Reset', style: TextStyle(color: kMainColor)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kMainColor,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              ),
                              onPressed: () async {
                                if (validateAndSave()) {
                                  if (isEdit) {
                                    if (!permissionService.hasPermission(Permit.branchesUpdate.value)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('You do not have permission to update branch.')),
                                      );
                                      return;
                                    }

                                    EasyLoading.show();
                                    await BranchRepo().updateBranch(
                                      ref: ref,
                                      context: context,
                                      id: widget.branchData!.id.toString(),
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      address: addressController.text,
                                      branchOpeningBalance: openingBalanceController.text,
                                      description: descriptionController.text,
                                    );
                                  } else {
                                    // 🔹 Add Mode
                                    if (!permissionService.hasPermission(Permit.branchesCreate.value)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('You do not have permission to create branch.')),
                                      );
                                      return;
                                    }

                                    EasyLoading.show();
                                    await BranchRepo().createBranch(
                                      ref: ref,
                                      context: context,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      address: addressController.text,
                                      branchOpeningBalance: openingBalanceController.text,
                                      description: descriptionController.text,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                isEdit ? 'Update' : 'Save',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
