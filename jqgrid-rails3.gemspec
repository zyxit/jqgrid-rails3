# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
Gem::Specification.new do |s|
  s.name        = "jqgrid-rails3"
  s.version     = "0.3"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anthony Heukmes"]
  s.email       = ["kostya@sqanta.com"]
  s.homepage    = "http://www.2dconcept.com/jquery-grid-rails-plugin"
  s.summary     = "jQuery grid plugin for rails 3 packed as gem."
  s.description = "jQuery grid plugin for rails 3 packed as gem."

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = Dir.glob("{lib,public}/**/*") + %w(MIT-LICENSE README.rdoc Rakefile)
  s.require_paths = [%q{lib}]
end