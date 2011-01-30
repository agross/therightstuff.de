# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cri}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denis Defreyne"]
  s.date = %q{2009-11-02}
  s.description = %q{Cri is a library for building easy-to-use commandline tools.}
  s.email = %q{denis.defreyne@stoneship.org}
  s.extra_rdoc_files = ["ChangeLog", "LICENSE", "README"]
  s.files = ["ChangeLog", "LICENSE", "NEWS", "README", "Rakefile", "VERSION", "lib/cri.rb", "lib/cri/base.rb", "lib/cri/command.rb", "lib/cri/core_ext.rb", "lib/cri/core_ext/string.rb", "lib/cri/option_parser.rb"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Cri is a library for building easy-to-use commandline tools.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
