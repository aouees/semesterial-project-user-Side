abstract class AppStates {
  String get nameState;
  @override
  String toString() {
    return nameState;
  }
}

class InitialAppState extends AppStates {
  @override
  String get nameState => "initial state";
}

class ChaangePasswordVisibility extends AppStates {
  @override
  String get nameState => "ChangePassWordVisibility";
}

class ChangeBottomState extends AppStates {
  @override
  String get nameState => "ChangeBottomState";
}

class ChangeSelectedDayInWeekTable extends AppStates {
  @override
  String get nameState => "ChangeSelectedDayInWeekTable";
}
