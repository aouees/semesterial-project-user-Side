import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/constant.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class WeekTable extends StatefulWidget {
  @override
  State<WeekTable> createState() => _WeekTableState();
}

class _WeekTableState extends State<WeekTable> {
  // const WeekTable({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit MyAppcubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
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
              body: Column(
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
                          'جدول الرحلات الأسبوعية',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: mycolor.lightblack),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BuildItemofWeekTable(context: context, day: 'السبت'),
                          BuildItemofWeekTable(context: context, day: 'اللأحد'),
                          BuildItemofWeekTable(
                              context: context, day: 'الاثنين'),
                          BuildItemofWeekTable(
                              context: context, day: 'الثلاثاء'),
                          BuildItemofWeekTable(
                              context: context, day: 'الأربعاء'),
                          DefaultMaterialButton(
                            context: context,
                            text: 'إرسال ',
                            onpressed: () {},
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
