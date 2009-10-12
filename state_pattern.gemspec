# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{state_pattern}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Cadenas"]
  s.date = %q{2009-10-12}
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
     "VERSION",
     "lib/state_pattern.rb",
     "lib/state_pattern/invalid_transition_exception.rb",
     "lib/state_pattern/state.rb",
     "state_pattern.gemspec",
     "test/arguments_of_event_delegation_test.rb",
     "test/hook_test.rb",
     "test/querying_test.rb",
     "test/state_pattern_test.rb",
     "test/test_class_creation_helper.rb",
     "test/test_helper.rb",
     "test/transition_validations_test.rb"
  ]
  s.homepage = %q{http://github.com/dcadenas/state_pattern}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{statepattern}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{A Ruby state pattern implementation}
  s.test_files = [
    "test/arguments_of_event_delegation_test.rb",
     "test/hook_test.rb",
     "test/querying_test.rb",
     "test/state_pattern_test.rb",
     "test/test_class_creation_helper.rb",
     "test/test_helper.rb",
     "test/transition_validations_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
