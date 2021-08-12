module Telemetry
  module Logger
    module ExceptionHandler
      def exception(exc, level: 'error', backtrace: true, backtrace_limit: 20, **opts)
        level = 'unknown' unless %w[debug info warn error fatal].include? level.to_s
        Telemetry::Logger.send(level, "#{exc.class}: #{exc.message}")
        Telemetry::Logger.send(level, exc.backtrace[0..backtrace_limit]) if backtrace && !exc.backtrace.nil?

        send_to_apm(exc, level: level)

        raise(exc) if opts[:raise]
      end

      def send_to_apm(exc, **opts)
        handled = opts[:handled] || %w[info debug].include?(opts[:level])
        ::ElasticAPM.report(exc, handled: handled) if elastic_apm?
        ::OpenTelemetry.handle_error(exception: exc, message: exc.message) if open_telemetry?
      end

      def elastic_apm?
        @elastic_apm unless @elastic_apm.nil?

        @elastic_apm = Kernel.const_defined? 'ElasticAPM'
      end

      def open_telemetry?
        @open_telemetry unless @open_telemetry.nil?

        @open_telemetry = Kernel.const_defined? 'OpenTelemetry'
      end
    end
  end
end
