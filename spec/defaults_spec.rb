require 'spec_helper'
require 'telemetry/logger/version'
require 'telemetry/logger/defaults'

RSpec.describe Telemetry::Logger::Defaults do
  it { should be_a Module }
  before :all do
    @class = Class.new do
      def initialize(**opts)
        @opts = opts
      end
      include Telemetry::Logger::Defaults
    end
  end

  it 'should have an env_prefix' do
    expect(@class.new.env_prefix).to eq 'telemetry'
    expect(@class.new(env_prefix: 'foobar').env_prefix).to eq 'foobar'
  end

  it 'should have a socket_hostname' do
    expect(@class.new.socket_hostname).to be_a String
  end

  it 'should have an application' do
    expect(@class.new.application).to eq 'telemetry'
    expect(@class.new(application: 'foobar').application).to eq 'foobar'
  end

  it 'should have an app_version' do
    expect(@class.new.app_version).to eq Telemetry::Logger::VERSION
    expect(@class.new(app_version: 'foobar').app_version).to eq 'foobar'
  end
end
