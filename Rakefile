require 'rubygems'
require 'echoe'

require 'rake'
require 'rspec/core/rake_task'

Echoe.new("websnap", "0.1.4") do |p|
  p.author = "Francis Chong"
  p.description = "Create snapshot of webpage"
  p.url = "http://github.com/siuying/websnap"
  p.ignore_pattern = []
  p.development_dependencies = ["rspec", "echoe", "mocha"]
  p.runtime_dependencies = []
end

RSpec::Core::RakeTask.new('spec') do |t|
end