# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{adsf}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denis Defreyne"]
  s.date = %q{2010-04-05}
  s.default_executable = %q{adsf}
  s.description = %q{a tiny static file server}
  s.email = %q{denis.defreyne@stoneship.org}
  s.executables = ["adsf"]
  s.files = ["ChangeLog", "LICENSE", "NEWS.rdoc", "Rakefile", "README.rdoc", "bin/adsf", "lib/adsf/rack/index_file_finder.rb", "lib/adsf/rack.rb", "lib/adsf.rb"]
  s.homepage = %q{http://stoneship.org/software/adsf/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.5")
  s.rubyforge_project = %q{adsf}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{a tiny static file server}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
    else
      s.add_dependency(%q<rack>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.0"])
  end
end
