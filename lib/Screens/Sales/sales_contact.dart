import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_pos/Const/api_config.dart';
import 'package:mobile_pos/Provider/add_to_cart.dart';
import 'package:mobile_pos/Screens/Customers/add_customer.dart';
import 'package:mobile_pos/Screens/Sales/add_sales.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/glonal_popup.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../core/theme/_app_colors.dart';
import '../../currency.dart';
import '../../model/business_info_model.dart' as business;
import '../../widgets/empty_widget/_empty_widget.dart';
import '../Customers/Provider/customer_provider.dart';

class SalesContact extends StatefulWidget {
  const SalesContact({super.key});

  @override
  SalesContactState createState() => SalesContactState();
}

class SalesContactState extends State<SalesContact> {
  late Color color;
  bool _isRefreshing = false;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  Future<void> refreshData(WidgetRef ref) async {
    if (_isRefreshing) return;
    _isRefreshing = true;

    ref.refresh(partiesProvider);

    await Future.delayed(const Duration(seconds: 1));
    _isRefreshing = false;
  }

  String? partyType;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Consumer(builder: (context, ref, __) {
      final businessInfo = ref.watch(businessInfoProvider);
      final providerData = ref.watch(partiesProvider);

      return businessInfo.when(data: (details) {
        return GlobalPopup(
          child: Scaffold(
            backgroundColor: kWhite,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0.0,
              centerTitle: true,
              actionsPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                lang.S.of(context).chooseCustomer,
                style: _theme.textTheme.titleMedium,
              ),
            ),
            body: RefreshIndicator.adaptive(
              onRefresh: () => refreshData(ref),
              child: SingleChildScrollView(
                child: providerData.when(data: (customer) {
                  final filteredCustomers = customer.where((c) {
                    final normalizedType = (c.type ?? '').toLowerCase();
                    if (normalizedType == 'supplier') return false;

                    final nameMatches = !_isSearching || _searchController.text.isEmpty
                        ? true
                        : (c.name ?? '').toLowerCase().contains(
                              _searchController.text.toLowerCase(),
                            );

                    final effectiveType = normalizedType == 'retailer' ? 'customer' : normalizedType;

                    final typeMatches = partyType == null || partyType!.isEmpty ? true : effectiveType == partyType;

                    return nameMatches && typeMatches;
                  }).toList();
                  return customer.isNotEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                              child: TextFormField(
                                controller: _searchController,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: lang.S.of(context).search,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF7F7F7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              )),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              hint: Text('Select Type'),
                                              icon: partyType != null
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.clear,
                                                        color: kMainColor,
                                                        size: 18,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          partyType = null;
                                                        });
                                                      },
                                                    )
                                                  : Icon(Icons.keyboard_arrow_down, color: kPeraColor),
                                              value: partyType,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  partyType = value;
                                                });
                                              },
                                              items: [
                                                'Customer',
                                                // 'Supplier',
                                                'Dealer',
                                                'Wholesaler',
                                              ].map((entry) {
                                                final valueToStore = entry.toLowerCase(); // Store lowercase value
                                                return DropdownMenuItem<String>(
                                                  value: valueToStore,
                                                  child: Text(
                                                    entry,
                                                    style: _theme.textTheme.bodyLarge?.copyWith(color: kTitleColor),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  setState(() {
                                    _isSearching = value.isNotEmpty;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              onTap: () async {
                                AddSalesScreen(customerModel: null).launch(context);
                                ref.refresh(cartNotifier);
                              },
                              leading: SizedBox(
                                height: 40.0,
                                width: 40.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/no_shop_image.png',
                                      fit: BoxFit.cover,
                                      width: 120.0,
                                      height: 120.0,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                lang.S.of(context).walkInCustomer,
                                style: _theme.textTheme.bodyMedium?.copyWith(
                                  color: kTitleColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              subtitle: Text(
                                lang.S.of(context).guest,
                                style: _theme.textTheme.bodyLarge,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Color(0xff4B5563),
                              ),
                            ),
                            ListView.builder(
                              itemCount: filteredCustomers.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (_, index) {
                                final item = filteredCustomers[index];
                                final normalizedType = (item.type ?? '').toLowerCase();
                                color = Colors.white;
                                if (normalizedType == 'retailer' || normalizedType == 'customer') color = const Color(0xFF56da87);
                                if (normalizedType == 'wholesaler') color = const Color(0xFF25a9e0);
                                if (normalizedType == 'dealer') color = const Color(0xFFff5f00);
                                if (normalizedType == 'supplier') color = const Color(0xFFA569BD);

                                final effectiveDisplayType = normalizedType == 'retailer' ? 'Customer' : item.type ?? '';

                                return ListTile(
                                  visualDensity: const VisualDensity(vertical: -2),
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () async {
                                    AddSalesScreen(customerModel: item).launch(context);
                                    ref.refresh(cartNotifier);
                                  },
                                  leading: item.image != null
                                      ? Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: DAppColors.kBorder, width: 0.3),
                                            image: DecorationImage(
                                              image: NetworkImage('${APIConfig.domain}${item.image ?? ''}'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : CircleAvatarWidget(name: item.name),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: _theme.textTheme.bodyMedium?.copyWith(
                                            color: kTitleColor,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$currency${item.due}',
                                        style: _theme.textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          effectiveDisplayType,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: _theme.textTheme.bodyMedium?.copyWith(
                                            color: color,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.due != null && item.due != 0 ? lang.S.of(context).due : lang.S.of(context).noDue,
                                        style: _theme.textTheme.bodyMedium?.copyWith(
                                          color: item.due != null && item.due != 0 ? const Color(0xFFff5f00) : DAppColors.kSecondary,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                    color: Color(0xff4B5563),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            AddSalesScreen(customerModel: null).launch(context);
                            ref.refresh(cartNotifier);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'images/no_shop_image.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.S.of(context).walkInCustomer,
                                      style: _theme.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      lang.S.of(context).guest,
                                      style: _theme.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios, color: kGreyTextColor),
                              ],
                            ),
                          ),
                        );
                }, error: (e, stack) {
                  return Text(e.toString());
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                }),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  if (details.data?.subscriptionDate != null && details.data?.enrolledPlan != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddParty()));
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(lang.S.of(context).addCustomers),
              ),
            ),
          ),
        );
      }, error: (e, stack) {
        return Text(e.toString());
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      });
    });
  }
}
