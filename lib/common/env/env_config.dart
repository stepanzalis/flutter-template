/// Env config
/// Given in runtime by --dart-define=environment=DEV
class EnvConfig {
  static const env = String.fromEnvironment(
    Env.environment,
    defaultValue: Env.prod,
  );

  static const isTestEnvironment = env == Env.stage;
}

/// Environment constants
class Env {
  static const environment = "environment";

  static const String stage = "STAGE";
  static const String prod = "PROD";
}
