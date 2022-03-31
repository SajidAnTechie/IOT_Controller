class Config {
  static String baseURL = 'homeappliance.herokuapp.com';
  static String login = '/api/v1/auth/login';
  static String register = '/api/v1/auth/register';
  static String verify = '/api/v1/auth/verify-email';
  static String setSchedule = '/api/v1/schedule/set-schedule';
  static String apiCachedLoginKey = 'user_info';
  static String authAppliace = '/api/v1/appliance/auth';
  static String updateAppliance = '/api/v1/appliance/updateState';
  static String applianceLog = '/api/v1/appliance/auth-appliancesLog';
}
