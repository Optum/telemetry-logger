# Telemetry::Logger
A generic gem to handle logging for all other telemetry gems

#### Setting up the logger
```ruby
Telemetry::Logger.setup(level: 'warn', color: false, log_file: './telemetry.log')

opts = {
  include_pid: false,
  level: 'info',
  log_file: nil,
  color: true,
  application: 'telemetry',
  app_version: Telemetry::Logger::VERSION
}
```

#### Example Logging
```ruby
Telemetry::Logger.setup(level: 'info')
Telemetry::Logger.info 'test info'

Telemetry::Logger.debug 'test debug'
Telemetry::Logger.warn 'test warn'
Telemetry::Logger.error 'test error'
Telemetry::Logger.fatal 'test fatal'
Telemetry::Logger.unknown 'test unknown'
```

#### Example Exception Tracking
Instead of repeating the same error method all over the place for exceptions, you can use the `exception` method to 
save on complexity and automatically report exceptions to supported APMs

```ruby
Telemetry::Logger.setup(level: 'info')
Telemetry::Logger.exception(StandardError.new('test error'), level: 'warn')
Telemetry::Logger.exception(StandardError.new('test error'), level: 'fatal')
Telemetry::Logger.exception(StandardError.new('test error'), handled: true)
Telemetry::Logger.exception(StandardError.new('test error'), backtrace: true)

# options for exception method
opts = {
  level: 'error', # sets the log level
  handled: true, # tells the apms if we handled this exception
  backtrace: true, # should we log the backtrace?
  backtrace_limit: 20, # how many lines should we limit the backtrace to?
  raise: false, # should we reraise this exception instead of swallowing it?
}
```