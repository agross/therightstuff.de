# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nanoc3}
  s.version = "3.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denis Defreyne"]
  s.date = %q{2011-05-03}
  s.default_executable = %q{nanoc3}
  s.email = %q{denis.defreyne@stoneship.org}
  s.executables = ["nanoc3"]
  s.extra_rdoc_files = ["ChangeLog", "LICENSE", "README.md", "NEWS.md"]
  s.files = ["ChangeLog", "LICENSE", "NEWS.md", "Rakefile", "README.md", "lib/nanoc3/base/code_snippet.rb", "lib/nanoc3/base/compiler.rb", "lib/nanoc3/base/compiler_dsl.rb", "lib/nanoc3/base/context.rb", "lib/nanoc3/base/core_ext/array.rb", "lib/nanoc3/base/core_ext/hash.rb", "lib/nanoc3/base/core_ext/string.rb", "lib/nanoc3/base/core_ext.rb", "lib/nanoc3/base/data_source.rb", "lib/nanoc3/base/dependency_tracker.rb", "lib/nanoc3/base/directed_graph.rb", "lib/nanoc3/base/errors.rb", "lib/nanoc3/base/filter.rb", "lib/nanoc3/base/item.rb", "lib/nanoc3/base/item_rep.rb", "lib/nanoc3/base/layout.rb", "lib/nanoc3/base/notification_center.rb", "lib/nanoc3/base/ordered_hash.rb", "lib/nanoc3/base/plugin_registry.rb", "lib/nanoc3/base/rule.rb", "lib/nanoc3/base/rule_context.rb", "lib/nanoc3/base/site.rb", "lib/nanoc3/base.rb", "lib/nanoc3/cli/base.rb", "lib/nanoc3/cli/commands/autocompile.rb", "lib/nanoc3/cli/commands/compile.rb", "lib/nanoc3/cli/commands/create_item.rb", "lib/nanoc3/cli/commands/create_layout.rb", "lib/nanoc3/cli/commands/create_site.rb", "lib/nanoc3/cli/commands/debug.rb", "lib/nanoc3/cli/commands/help.rb", "lib/nanoc3/cli/commands/info.rb", "lib/nanoc3/cli/commands/update.rb", "lib/nanoc3/cli/commands/view.rb", "lib/nanoc3/cli/commands.rb", "lib/nanoc3/cli/logger.rb", "lib/nanoc3/cli.rb", "lib/nanoc3/data_sources/deprecated/delicious.rb", "lib/nanoc3/data_sources/deprecated/last_fm.rb", "lib/nanoc3/data_sources/deprecated/twitter.rb", "lib/nanoc3/data_sources/filesystem.rb", "lib/nanoc3/data_sources/filesystem_unified.rb", "lib/nanoc3/data_sources/filesystem_verbose.rb", "lib/nanoc3/data_sources.rb", "lib/nanoc3/extra/auto_compiler.rb", "lib/nanoc3/extra/chick.rb", "lib/nanoc3/extra/core_ext/enumerable.rb", "lib/nanoc3/extra/core_ext/time.rb", "lib/nanoc3/extra/core_ext.rb", "lib/nanoc3/extra/deployers/rsync.rb", "lib/nanoc3/extra/deployers.rb", "lib/nanoc3/extra/file_proxy.rb", "lib/nanoc3/extra/validators/links.rb", "lib/nanoc3/extra/validators/w3c.rb", "lib/nanoc3/extra/validators.rb", "lib/nanoc3/extra/vcs.rb", "lib/nanoc3/extra/vcses/bazaar.rb", "lib/nanoc3/extra/vcses/dummy.rb", "lib/nanoc3/extra/vcses/git.rb", "lib/nanoc3/extra/vcses/mercurial.rb", "lib/nanoc3/extra/vcses/subversion.rb", "lib/nanoc3/extra/vcses.rb", "lib/nanoc3/extra.rb", "lib/nanoc3/filters/bluecloth.rb", "lib/nanoc3/filters/coderay.rb", "lib/nanoc3/filters/colorize_syntax.rb", "lib/nanoc3/filters/erb.rb", "lib/nanoc3/filters/erubis.rb", "lib/nanoc3/filters/haml.rb", "lib/nanoc3/filters/kramdown.rb", "lib/nanoc3/filters/less.rb", "lib/nanoc3/filters/markaby.rb", "lib/nanoc3/filters/maruku.rb", "lib/nanoc3/filters/rainpress.rb", "lib/nanoc3/filters/rdiscount.rb", "lib/nanoc3/filters/rdoc.rb", "lib/nanoc3/filters/redcloth.rb", "lib/nanoc3/filters/relativize_paths.rb", "lib/nanoc3/filters/rubypants.rb", "lib/nanoc3/filters/sass.rb", "lib/nanoc3/filters.rb", "lib/nanoc3/helpers/blogging.rb", "lib/nanoc3/helpers/breadcrumbs.rb", "lib/nanoc3/helpers/capturing.rb", "lib/nanoc3/helpers/filtering.rb", "lib/nanoc3/helpers/html_escape.rb", "lib/nanoc3/helpers/link_to.rb", "lib/nanoc3/helpers/rendering.rb", "lib/nanoc3/helpers/tagging.rb", "lib/nanoc3/helpers/text.rb", "lib/nanoc3/helpers/xml_sitemap.rb", "lib/nanoc3/helpers.rb", "lib/nanoc3/tasks/clean.rake", "lib/nanoc3/tasks/clean.rb", "lib/nanoc3/tasks/deploy/rsync.rake", "lib/nanoc3/tasks/validate.rake", "lib/nanoc3/tasks.rb", "lib/nanoc3.rb", "bin/nanoc3"]
  s.homepage = %q{http://nanoc.stoneship.org/}
  s.post_install_message = %q{------------------------------------------------------------------------------
Thanks for installing nanoc 3.1! Here are some resources to help you get
started:

* The tutorial at <http://nanoc.stoneship.org/tutorial/>
* The manual at <http://nanoc.stoneship.org/manual/>
* The discussion group at <http://groups.google.com/group/nanoc>

Because nanoc 3.1 has quite a few new features, be sure to check out the nanoc
blog at <http://nanoc.stoneship.org/blog/> for details about this release.

Enjoy!
------------------------------------------------------------------------------
}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{a web publishing system written in Ruby for building small to medium-sized websites.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cri>, [">= 1.0.0"])
    else
      s.add_dependency(%q<cri>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<cri>, [">= 1.0.0"])
  end
end
