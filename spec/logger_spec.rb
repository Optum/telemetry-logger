require 'spec_helper'

RSpec.describe Telemetry::Logger do
  it { should be_a Module }
  it 'should have a version number' do
    expect(described_class::VERSION).to be_a String
  end
end
