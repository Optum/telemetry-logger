require 'socket'

module Telemetry
  module Logger
    module Defaults
      def socket_hostname
        Socket.gethostname.delete_suffix('.').downcase
      end

      def env_prefix
        opts[:env_prefix] || 'telemetry'
      end

      def application
        opts[:application] || 'telemetry'
      end

      def app_version
        opts[:app_version] || Telemetry::Logger::VERSION
      end

      def opts
        @opts ||= {}
      end
    end
  end
end
