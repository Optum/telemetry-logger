require 'telemetry/logger/version'
require 'telemetry/logger/defaults'
require 'telemetry/logger/builder'
require 'telemetry/logger/methods'

module Telemetry
  module Logger
    class << self
      include Telemetry::Logger::Defaults
      include Telemetry::Logger::Methods
      include Telemetry::Logger::Builder

      def setup(level: 'info', **opts)
        output(**opts)
        self.log_level = level
      end
    end
  end
end
