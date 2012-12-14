require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |task|
  task.libs << "spec"
  task.test_files = FileList["spec/**/*_spec.rb"]
end

task :default => [:test, :build]