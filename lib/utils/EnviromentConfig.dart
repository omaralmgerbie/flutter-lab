class EnvironmentConfig {
  static const CLIENT_ID =
      String.fromEnvironment('CLIENT_ID', defaultValue: 'run from terminal');
}
