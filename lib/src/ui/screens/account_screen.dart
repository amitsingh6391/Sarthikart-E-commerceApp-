import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/src/bloc/selected_address/account_details_cubit.dart';
import 'package:fluttercommerce/src/bloc/selected_address/account_details_state.dart';
import 'package:fluttercommerce/src/di/app_injector.dart';
import 'package:fluttercommerce/src/repository/auth_repository.dart';
import 'package:fluttercommerce/src/res/string_constants.dart';
import 'package:fluttercommerce/src/res/text_styles.dart';
import 'package:fluttercommerce/src/routes/router.gr.dart';
import 'package:fluttercommerce/src/ui/common/action_text.dart';

import 'order_details.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var accountDetailsCubit = AppInjector.get<AccountDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
                          cubit: accountDetailsCubit,
                          builder: (context, accountDetailState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  accountDetailState.accountDetails.name,
                                  style: AppTextStyles.medium22Black,
                                ),
                                Text(
                                  accountDetailState.accountDetails.phoneNumber,
                                  style: AppTextStyles.normal14Color4C4C6F,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ActionText(
                          StringsConstants.editCaps,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                Routes.addUserDetailScreen,
                                arguments: AddUserDetailScreenArguments(
                                    newAddress: false));
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(StringsConstants.myOrders),
                    leading: Icon(Icons.shopping_basket),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.myOrdersScreen);
                    },
                  ),
                  ListTile(
                    title: Text(StringsConstants.myAddress),
                    leading: Icon(Icons.place),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.myAddressScreen);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(StringsConstants.logout),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      AppInjector.get<AuthRepository>()
                          .logoutUser()
                          .then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginScreen, (route) => false);
                      });
                    },
                  ),
                  Divider(),
                  BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
                    cubit: accountDetailsCubit,
                    builder: (context, accountDetailState) {
                      return (accountDetailState.accountDetails.phoneNumber == "+917905517621" ||
                              accountDetailState.accountDetails.phoneNumber ==
                                  "+919532506142" ||
                              accountDetailState.accountDetails.phoneNumber ==
                                  "+919548582776")
                          ? ListTile(
                              title: Text("Coustmer orders"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetails(),
                                  ),
                                );
                              },
                            )
                          : SizedBox();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
