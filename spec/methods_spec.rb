require 'spec_helper'
require 'telemetry/logger/version'
require 'telemetry/logger/methods'

RSpec.describe Telemetry::Logger::Methods do
  it { should be_a Module }
  before :all do
    @class = Class.new do
      include Telemetry::Logger::Methods
      include Telemetry::Logger::Builder

      def initialize(**opts)
        @opts = opts
      end

      def opts
        @opts ||= {}
      end
    end
  end

  it 'can colorize' do
    expect(@class.new(color: false).colorize).to eq false
    expect(@class.new(color: true).colorize).to eq true
    expect(@class.new.colorize).to eq true
    expect(@class.new(color: true, logfile: './test.log').colorize).to eq false
  end

  it 'can debug' do
    expect { @class.new.debug('testing') }.to output(/DEBUG/).to_stdout_from_any_process
    expect { @class.new(level: 'debug').debug('testing') }.to output(/DEBUG/).to_stdout_from_any_process
    expect { @class.new(level: 'info').debug('testing') }.not_to output(/DEBUG/).to_stdout_from_any_process
    expect { @class.new(level: 'warn').debug('testing') }.not_to output(/DEBUG/).to_stdout_from_any_process
    expect { @class.new(level: 'error').debug('testing') }.not_to output(/DEBUG/).to_stdout_from_any_process
    expect { @class.new(level: 'fatal').debug('testing') }.not_to output(/DEBUG/).to_stdout_from_any_process
  end

  it 'can info' do
    expect { @class.new.info('testing') }.to output(/INFO/).to_stdout_from_any_process
    expect { @class.new(level: 'info').info('testing') }.to output(/INFO/).to_stdout_from_any_process
    expect { @class.new(level: 'info').debug('testing') }.not_to output(/DEBUG/).to_stdout_from_any_process
  end

  it 'can warn' do
    expect { @class.new.warn('testing') }.to output(/WARN/).to_stdout_from_any_process
    expect { @class.new(level: 'warn').warn('testing') }.to output(/WARN/).to_stdout_from_any_process
  end

  it 'can error' do
    expect { @class.new.error('testing') }.to output(/ERROR/).to_stdout_from_any_process
    expect { @class.new(level: 'error').error('testing') }.to output(/ERROR/).to_stdout_from_any_process
  end

  it 'can fatal' do
    expect { @class.new.fatal('testing') }.to output(/FATAL/).to_stdout_from_any_process
    expect { @class.new(level: 'fatal').fatal('testing') }.to output(/FATAL/).to_stdout_from_any_process
  end

  it 'can unknown' do
    expect { @class.new.unknown('testing') }.to output(/ANY/).to_stdout_from_any_process
  end

  it 'can return thread info' do
    expect(@class.new.thread).to be_a String
    expect(@class.new.thread(kvl: false)).to be_a String
    expect(@class.new.thread(kvl: true)).to be_a String
  end

  it 'has an opts hash' do
    expect(@class.new.opts).to eq({})
  end
end
