require 'spec_helper'
require 'telemetry/logger/version'
require 'telemetry/logger/builder'

RSpec.describe Telemetry::Logger::Builder do
  it { should be_a Module }
  before :all do
    @class = Class.new do
      def initialize(**opts)
        @opts = opts
      end
      include Telemetry::Logger::Builder
    end
  end

  it 'should respond to log' do
    expect(@class.new(level: 'debug').level).to eq 0
    expect(@class.new(level: 'info').level).to eq 1
    expect(@class.new(level: 'warn').level).to eq 2
    expect(@class.new(level: 'error').level).to eq 3
    expect(@class.new(level: 'fatal').level).to eq 4
  end

  it 'should respond to level' do
    expect(@class.new.log_level = 'warn').to eq 'warn'
    expect(@class.new.level).to eq 0
    new_class = @class.new(level: 'warn')
    new_class.log_level = 'warn'
    expect(new_class.level).to eq 2
  end

  it 'can modify the log level' do
    modify_level = @class.new
    expect(modify_level.level).to eq 0
    expect { modify_level.log_level = 'debug' }.not_to raise_exception
    expect(modify_level.level).to eq 0
    expect { modify_level.log_level = 'info' }.not_to raise_exception
    expect(modify_level.level).to eq 1
    expect { modify_level.log_level = 'warn' }.not_to raise_exception
    expect(modify_level.level).to eq 2
    expect { modify_level.log_level = 'error' }.not_to raise_exception
    expect(modify_level.level).to eq 3
    expect { modify_level.log_level = 'fatal' }.not_to raise_exception
    expect(modify_level.level).to eq 4

    expect(modify_level.log_level = nil).to eq nil
    expect(modify_level.level).to eq 42

    expect(modify_level.log_level = 'foobar').to eq 'foobar'
    expect(modify_level.level).to eq 0

    expect(modify_level.log_level = 111).to eq 111
    expect(modify_level.level).to eq 111
  end

  it 'can call the formatter' do
    expect(@class.new.format).to be_a Proc
    expect(@class.new.format(include_pid: true)).to be_a Proc
  end
end
