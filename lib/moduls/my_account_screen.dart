import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/models/user.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountSccreen extends StatefulWidget {
  const MyAccountSccreen({super.key});

  @override
  State<MyAccountSccreen> createState() => _MyAccountSccreenState();
}

class _MyAccountSccreenState extends State<MyAccountSccreen> {
  var formkey = GlobalKey<FormState>();
  var Namecontroller = TextEditingController();
  var Emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var Phonecontroller = TextEditingController();
  var Addresscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Namecontroller.text = MyData.user!.userName!;
    Emailcontroller.text = MyData.user!.userEmail!;
    passwordcontroller.text = MyData.user!.userPassword!;
    Phonecontroller.text = MyData.user!.userPhone!;
    Addresscontroller.text = MyData.user!.userAddress!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        AppCubit mycubit = AppCubit.get(context);
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              mycolor.blue,
              mycolor.yello,
            ],
          )),
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: BlocConsumer<DataBase, DatabaseStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.541),
                                  blurRadius: 15,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          margin: EdgeInsets.all(15),
                          height: 0.07 * MediaQuery.of(context).size.height,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_outlined,
                                  color: mycolor.blue,
                                ),
                              ),
                              Text(
                                '??????????',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: mycolor.blue),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 15,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                DefoultFormField(
                                  controller: Namecontroller,
                                  myhinttext: '?????????? ',
                                  suffixicon: Icons.account_circle,
                                  typeofkeybord: TextInputType.text,
                                  mytextalign: TextAlign.end,
                                  validate: (String? m) {
                                    if (m!.isEmpty) return "?????? ?????????? ?????????? ";
                                    return null;
                                  },
                                ),
                                DefoultFormField(
                                  controller: Emailcontroller,
                                  myhinttext: '?????????????? ',
                                  suffixicon: Icons.email,
                                  typeofkeybord: TextInputType.emailAddress,
                                  mytextalign: TextAlign.end,
                                  validate: (String? m) {
                                    if (m!.isEmpty) return "?????? ?????????? ?????????????? ";
                                    return null;
                                  },
                                ),
                                DefoultFormField(
                                  controller: passwordcontroller,
                                  myhinttext: '???????? ???????????? ',
                                  suffixicon: Icons.remove_red_eye_outlined,
                                  typeofkeybord: TextInputType.text,
                                  mytextalign: TextAlign.end,
                                  prefix: mycubit.prefix,
                                  ispassword: mycubit.ispassword,
                                  prefixpressed: () {
                                    mycubit.changepasswordvisibility();
                                  },
                                  validate: (String? m) {
                                    if (m!.isEmpty ||
                                        (m.length < 3 || m.length > 10))
                                      return " ?????? ?????????? ???????? ???????? ???? ???????? ?????? ?????? ?????????? ";
                                    return null;
                                  },
                                ),
                                DefoultFormField(
                                  controller: Phonecontroller,
                                  myhinttext: '?????? ???????????? ',
                                  suffixicon: Icons.phone,
                                  typeofkeybord: TextInputType.phone,
                                  mytextalign: TextAlign.end,
                                  validate: (String? m) {
                                    if (m!.isEmpty)
                                      return "?????? ?????????? ?????? ???????????? ";
                                    return null;
                                  },
                                ),
                                DefoultFormField(
                                    controller: Addresscontroller,
                                    myhinttext: '???????? ?????????????? ',
                                    typeofkeybord: TextInputType.text,
                                    suffixicon: Icons.location_city,
                                    validate: (String? m) {
                                      if (m!.isEmpty)
                                        return "?????? ???????????? ?????????? ";
                                      return null;
                                    },
                                    ontap: () {
                                      MyDropdown(
                                        controller: Addresscontroller,
                                        mylist: mycubit.mymenue,
                                        context: this.context,
                                        title: "?????????????? ",
                                      );
                                    }),
                                owbutton(onpress: () {
                                  if (formkey.currentState!.validate()) {
                                    User u = User(
                                      userId: MyData.user!.userId,
                                      userName: Namecontroller.text,
                                      userAddress: Addresscontroller.text,
                                      userEmail: Emailcontroller.text,
                                      userPassword: passwordcontroller.text,
                                      userPhone: Phonecontroller.text,
                                    );
                                    DataBase.get(context).UpdateAccountInfo(u);
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
