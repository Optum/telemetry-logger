# frozen_string_literal: true

require_relative 'lib/telemetry/logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'telemetry-logger'
  spec.version       = Telemetry::Logger::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matt.iverson@optum.com']

  spec.summary       = 'Telemetry Logging Gem'
  spec.description   = 'A generic gem to handle logging for all other telemetry gems'
  spec.homepage      = 'https://github.com/Optum/telemetry-logger'
  spec.license       = 'Apache-2.0'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Optum/telemetry-logger'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/Optum/telemetry-logger/issues'
  spec.metadata['changelog_uri'] = 'https://github.com/Optum/telemetry-logger/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'concurrent-ruby', '>= 1.1.7'
  spec.add_dependency 'concurrent-ruby-ext', '>= 1.1.7'
  spec.add_dependency 'multi_json'
  spec.add_dependency 'oj', '>= 3.11'
  spec.add_dependency 'rainbow', '~> 3'
end
