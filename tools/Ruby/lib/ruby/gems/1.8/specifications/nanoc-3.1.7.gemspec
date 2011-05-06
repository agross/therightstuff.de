# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nanoc}
  s.version = "3.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denis Defreyne"]
  s.date = %q{2011-05-03}
  s.description = %q{a web publishing system written in Ruby for building small to medium-sized websites.}
  s.email = %q{denis.defreyne@stoneship.org}
  s.executables = ["nanoc", "nanoc-select"]
  s.files = ["bin/nanoc", "bin/nanoc-select", "lib/nanoc-select.rb"]
  s.homepage = %q{http://nanoc.stoneship.org/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{a web publishing system written in Ruby for building small to medium-sized websites.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nanoc3>, [">= 3.1.7"])
    else
      s.add_dependency(%q<nanoc3>, [">= 3.1.7"])
    end
  else
    s.add_dependency(%q<nanoc3>, [">= 3.1.7"])
  end
end
