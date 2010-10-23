# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = %q{state_pattern}
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Cadenas"]
  s.date = %q{2010-10-09}
  s.email = %q{dcadenas@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitignore",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "rails/init.rb"
  ] + Dir[File.join(File.dirname(__FILE__),'lib/**/*')]
  s.homepage = %q{http://github.com/dcadenas/state_pattern}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{statepattern}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Ruby state pattern implementation}
  s.test_files = Dir[File.join(File.dirname(__FILE__),'examples/**/*')] + Dir[File.join(File.dirname(__FILE__),'test/**/*')]
end

