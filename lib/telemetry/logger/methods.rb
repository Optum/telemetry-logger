module Telemetry
  module Logger
    module Methods
      def colorize
        @colorize ||= if opts[:logfile].is_a?(String)
                        false
                      elsif opts.key? :color
                        opts[:color]
                      else
                        true
                      end
      end

      def debug(message = nil)
        return unless log.level < 1

        message = yield if message.nil? && block_given?
        message = Rainbow(message).blue if @color
        log.debug(message)
      end

      def info(message = nil)
        return unless log.level < 2

        message = yield if message.nil? && block_given?
        message = Rainbow(message).green if @color
        log.info(message)
      end

      def warn(message = nil)
        return unless log.level < 3

        message = yield if message.nil? && block_given?
        message = Rainbow(message).yellow if @color
        log.warn(message)
      end

      def error(message = nil)
        return unless log.level < 4

        message = yield if message.nil? && block_given?
        message = Rainbow(message).red if @color
        log.error(message)
      end

      def fatal(message = nil)
        return unless log.level < 5

        message = yield if message.nil? && block_given?
        message = Rainbow(message).darkred if @color
        log.fatal(message)
      end

      def unknown(message = nil)
        message = yield if message.nil? && block_given?
        message = Rainbow(message).purple if @color
        log.unknown(message)
      end

      def thread(kvl: false, **_opts)
        if kvl
          "thread=#{Thread.current.object_id}"
        else
          Thread.current.object_id.to_s
        end
      end
    end
  end
end
