require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "git2mite"
    gem.summary = %Q{writes your git commit messages to your mite account}
    gem.email = "alex@upstre.am"
    gem.homepage = "http://github.com/upstream/git2mite"
    gem.authors = ["Alexander Lang", 'Thilo Utke', 'Robin Mehner']
    gem.files = FileList["[A-Z]*.*", "lib/**/*"]
    gem.add_dependency 'json'
    gem.add_dependency 'rest-client'
    gem.add_dependency 'builder'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
desc "Run all specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/*_spec.rb']
end

task :default => :spec
