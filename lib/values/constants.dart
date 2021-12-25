class PreferenceKey {
  static const String userSession = 'userSession';
}

class Texts {}

class InputKeys {
  static String id = 'id';
}

class Values {
  static double buttonRadius() => 11;

  static double inputFieldRadius() => 6.0;

  static double prankCardRadius() => 6.0;

  static double reactionCardRadius() => 6.0;

  static bool isStaging() => true;
}

class Constant {
  static String user = 'user';
  static String token = 'token';

  static const String dateTimeFormat = 'dd-MM-yyyy HH:mm:ss';
  static const String dateFormat = "dd-MM-yyyy";
  static const String timeFormat = "HH:mm:ss";
}

class FireStore {
  static String users = 'users';
}
