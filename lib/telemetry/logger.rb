require 'telemetry/logger/version'
require 'telemetry/logger/defaults'
require 'telemetry/logger/builder'
require 'telemetry/logger/methods'
require 'telemetry/logger/exception_handler'

module Telemetry
  module Logger
    class << self
      include Telemetry::Logger::Defaults
      include Telemetry::Logger::Methods
      include Telemetry::Logger::Builder
      include Telemetry::Logger::ExceptionHandler

      def setup(level: 'info', **opts)
        @opts = opts
        output(**opts)
        self.log_level = level
        self
      end
    end
  end
end
