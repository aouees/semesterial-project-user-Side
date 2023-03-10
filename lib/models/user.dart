import 'package:mysql1/mysql1.dart';

class User {
  int? userId;
  String? userName, userAddress, userPhone, userEmail, userPassword;

  User({
    this.userId,
    required this.userName,
    this.userPhone,
    this.userAddress,
    this.userEmail,
    this.userPassword,
  });

  static User fromDB(ResultRow row) {
    return User(
      userId: row[0],
      userName: row[1],
      userPhone: row[2],
      userAddress: row[3],
      userEmail: row[4],
      userPassword: row[5],
    );
  }
}
