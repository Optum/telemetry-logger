# Telemetry::Logger

## v0.2.0
* Adding new module called `Telemetry::Logger::ExceptionHandler`
* Adding methods for `exception` and magic for detecting `ElasticAPM` and `OpenTelemetry`
* Adding `Upload Sarif output` step to `rubocop` GitHub action

## v0.1.1
* Fixing issue with color option using the wrong method name
* Removing format logger from the setup command
* Changing setup method to return `self`
* Removing `concurrent-ruby` and `oj` as a dependency

## v0.1.0
Initial release