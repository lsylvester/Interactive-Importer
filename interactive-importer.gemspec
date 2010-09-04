# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'interactive-importer/version'
 
Gem::Specification.new do |s|
  s.name        = "interactive-importer"
  s.version     = CsvImporter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lachlan Sylvester"]
  s.email       = ["lachlan.r.sylvester@gmail.com"]
  s.homepage    = "http://github.com/lsylvester/bundler"
  s.summary     = ""
  s.description = ""
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
  s.require_path = 'lib'
end