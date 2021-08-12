require 'spec_helper'
require 'telemetry/logger/exception_handler'

RSpec.describe Telemetry::Logger::ExceptionHandler do
  it { should be_a Module }
  before :all do
    @class = Class.new do
      # include Telemetry::Logger::ExceptionHandler
      def initialize
        extend Telemetry::Logger::ExceptionHandler
      end
    end

    Telemetry::Logger.log_level = 'debug'

    @exception = StandardError.new('this is my test exception')
  end

  it 'should be able to log exceptions' do
    expect(@class.new.exception(@exception))
    expect { @class.new.exception(@exception, level: 'debug') }.to output(/DEBUG/).to_stdout_from_any_process
    expect { @class.new.exception(@exception, level: 'info') }.to output(/INFO/).to_stdout_from_any_process
    expect { @class.new.exception(@exception, level: 'warn') }.to output(/WARN/).to_stdout_from_any_process
    expect { @class.new.exception(@exception, level: 'error') }.to output(/ERROR/).to_stdout_from_any_process
    expect { @class.new.exception(@exception, level: 'fatal') }.to output(/FATAL/).to_stdout_from_any_process
  end

  it 'should be able to re raise an exception' do
    expect { @class.new.exception(StandardError.new('test'), raise: true) }.to raise_exception StandardError
  end
end
