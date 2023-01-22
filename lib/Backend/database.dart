import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/shared/Constants/connectionDB.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';

import '../models/bus.dart';
import '../models/driver.dart';
import '../models/manager.dart';
import '../models/trip.dart';
import '../models/user.dart';

class DataBase extends Cubit<DatabaseStates> {
  DataBase() : super(InitialState());
  static DataBase get(context) => BlocProvider.of(context);

  MySqlConnection? _myDB;

  //===========================================================

  Future<void> connect() async {
    emit(LoadingState());
    await MySqlConnection.connect(ConnectionDB.settings).then((value) {
      _myDB = value;
      emit(Connected());
    }).catchError((error, stackTrace) {
      emit(ErrorConnectingDataState('[connect] $error'));
      print("Owis connect :($error) \n $stackTrace");
    });
  }

  //===========================================================

  Future<void> disConnect() async {
    emit(LoadingState());
    await _myDB!.close().then((value) {
      emit(DisConnected());
    }).catchError((error, stackTrace) {
      emit(ErrorDisConnectingDataState('[disConnect] $error'));
      print("Owis disConnect :($error) \n $stackTrace");
    });
  }

  //===========================================================

  Future<void> insertDriver(Driver d) async {
    emit(LoadingState());

    await _myDB!.query(
        'insert into driver (driver_name,driver_phone) values ( ?, ?);',
        [d.driverName, d.driverPhone]).then((value) {
      d.driverId = value.insertId!;
      MyData.driversList[d.driverId!] = d;
      emit(InsertedData("تم اضافة بيانات السائق الجديد"));
    }).catchError((error, stackTrace) {
      if (MyData.driversList.containsKey(d.driverId)) {
        MyData.driversList.remove(d.driverId);
      }
      emit(ErrorInsertingDataState('[insertDriver] $error'));
      print("Owis insertDriver :($error) \n $stackTrace");
    });
  }

//===========================================================

  Future<void> getDrivers() async {
    emit(LoadingState());
    MyData.driversList.clear();
    await _myDB!.query('select * from driver').then((value) {
      for (var row in value) {
        Driver d = Driver.fromDB(row);
        MyData.driversList[d.driverId!] = d;
      }
      emit(SelectedData("تم جلب بيانات السائقين "));
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('[getDrivers] $error'));
      print("Owis getDrivers :($error) \n $stackTrace");
    });
  }

  //===========================================================
  Future<void> getBus() async {
    emit(LoadingState());
    MyData.busList.clear();
    await _myDB!.query('select * from bus').then((value) {
      for (var row in value) {
        Bus b = Bus.fromDB(row);
        MyData.busList[b.busId!] = b;
      }
      emit(SelectedData("تم جلب بيانات الحافلات"));
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('[getBus] $error'));
      print("Owis getBus :($error) \n $stackTrace");
    });
  }

  //===========================================================

  Future<void> getUserTrips(User u) async {
    emit(LoadingState());
    await _myDB!.query('''
      select trip_id,trip_name,trip_type,trip_date,trip_price,
      concat( bus_type ,concat(' - ', bus_number)),
      driver_name from trip,bus,driver where
      driver_id=trip_driver_id 
      and bus_id=trip_bus_id and trip_id in (
      select reservatin_trip_id from reservation
      where resrervation_user_id = ? );
      ''', [u.userId]).then((value) {
      MyData.tripList.clear();

      for (var row in value) {
        Trip t = Trip.fromDB(row);
        MyData.tripList[t.tripId!] = t;
      }
      emit(SelectedData("تم جلب الرحلات التي قام بها المستخدم:${u.userName}"));
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('[getUserTrips] $error'));
      print("Owis getUserTrips :($error) \n $stackTrace");
    });
  }

  //===========================================================
  Future<void> getManager() async {
    emit(LoadingState());
    await _myDB!.query('select * from manager').then((value) {
      MyData.manager = Manager.fromDB(value.first);
      emit(SelectedData("تم جلب بيانات المدير"));
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('[getManager] $error'));
      print("Owis getManager :($error) \n $stackTrace");
    });
  }
  //===========================================================

  Future<void> getTime() async {
    emit(LoadingState());
    MyData.timeItems.clear();
    await _myDB!.query('select * from trip_time').then((value) {
      for (var row in value) {
        MyData.timeItems
            .add(SelectedListItem(name: row[1], value: row[0].toString()));
      }
      emit(SelectedData("تم جلب الاوقات "));
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('[getTime] $error'));
      print("Owis getTime :($error) \n $stackTrace");
    });
  }

  //===========================================================
}