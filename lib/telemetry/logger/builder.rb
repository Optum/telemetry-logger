require 'logger'

module Telemetry
  module Logger
    module Builder
      def opts
        @opts ||= {}
      end

      def format(include_pid: false, **)
        log.formatter = proc do |severity, datetime, _progname, msg|
          string = "[#{datetime}]"
          string.concat("[#{::Process.pid}]") if include_pid
          string.concat(" #{severity} #{msg}\n")
          string
        end
      end

      def log
        @log ||= output(**opts)
      end

      def output(**options)
        return @log unless @log.nil?

        @log = ::Logger.new(options[:log_file] || $stdout)
        self.log_level = options[:level] if options.key? :level
        self.format

        @log
      end

      def level
        log.level
      end

      def log_level=(level)
        log.level = case level
                    when 'trace', 'debug'
                      ::Logger::DEBUG
                    when 'info'
                      ::Logger::INFO
                    when 'warn'
                      ::Logger::WARN
                    when 'error'
                      ::Logger::ERROR
                    when 'fatal'
                      ::Logger::FATAL
                    when nil
                      42
                    else
                      if level.is_a? Integer
                        level
                      else
                        0
                      end
                    end
        @log = log
      end
    end
  end
end
