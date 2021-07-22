require 'spec_helper'
require 'telemetry/logger'

RSpec.describe Telemetry::Logger do
  it { should be_a Module }

  # before :all do
  #   Telemetry::Logger.setup(level: 'debug')
  # end
  it 'should have a version number' do
    expect(Telemetry::Logger::VERSION).to be_a String
  end

  it 'should have a setup command' do
    expect(Telemetry::Logger).to respond_to :setup
  end

  it 'should be able to log debug' do
    expect { Telemetry::Logger.debug('testing') }.to output(/DEBUG/).to_stdout_from_any_process
  end

  it 'should be able to log info' do
    expect { Telemetry::Logger.info('testing') }.to output(/INFO/).to_stdout_from_any_process
  end

  it 'should be able to log warn' do
    expect { Telemetry::Logger.warn('testing') }.to output(/WARN/).to_stdout_from_any_process
  end

  it 'should be able to log error' do
    expect { Telemetry::Logger.error('testing') }.to output(/ERROR/).to_stdout_from_any_process
  end

  it 'should be able to log fatal' do
    expect { Telemetry::Logger.fatal('testing') }.to output(/FATAL/).to_stdout_from_any_process
  end

  it 'should be able to log unknown' do
    expect { Telemetry::Logger.unknown('testing') }.to output(/ANY/).to_stdout_from_any_process
  end

  it 'should be able to setup and set the level' do
    expect(Telemetry::Logger.setup(level: 'warn').level).to eq 2
    expect(Telemetry::Logger.setup(level: 'error').level).to eq 3
  end
end
