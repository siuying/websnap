# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "websnap"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francis Chong"]
  s.date = "2012-12-11"
  s.description = "Create snapshot of webpage"
  s.email = ""
  s.executables = ["wkhtml_image_executable.rb", "wkhtmltoimage-amd64", "wkhtmltoimage-linux-i386-0.10.0", "wkhtmltoimage-osx-i386-0.10.0", "wkhtmltoimage-proxy"]
  s.extra_rdoc_files = ["LICENSE", "README.md", "bin/wkhtml_image_executable.rb", "bin/wkhtmltoimage-amd64", "bin/wkhtmltoimage-linux-i386-0.10.0", "bin/wkhtmltoimage-osx-i386-0.10.0", "bin/wkhtmltoimage-proxy", "lib/websnap.rb", "lib/websnap/source.rb", "lib/websnap/websnap.rb"]
  s.files = ["LICENSE", "Manifest", "README.md", "Rakefile", "bin/wkhtml_image_executable.rb", "bin/wkhtmltoimage-amd64", "bin/wkhtmltoimage-linux-i386-0.10.0", "bin/wkhtmltoimage-osx-i386-0.10.0", "bin/wkhtmltoimage-proxy", "lib/websnap.rb", "lib/websnap/source.rb", "lib/websnap/websnap.rb", "spec/fixtures/google.html", "spec/source_spec.rb", "spec/spec_helper.rb", "spec/websnap_spec.rb", "websnap.gemspec"]
  s.homepage = "http://github.com/siuying/websnap"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Websnap", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "websnap"
  s.rubygems_version = "1.8.15"
  s.summary = "Create snapshot of webpage"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
