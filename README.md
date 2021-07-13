# Telemetry::Logger
A generic gem to handle logging for all other telemetry gems

Example
```ruby
Telemetry::Logger.setup(level: 'info')
Telemetry::Logger.info 'test info'
Telemetry::Logger.debug 'test debug'
Telemetry::Logger.warn 'test warn'
Telemetry::Logger.error 'test error'
Telemetry::Logger.fatal 'test fatal'
Telemetry::Logger.unknown 'test unknown'
```
