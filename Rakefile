require 'rake'

begin
  require 'rubygems'
  gem 'echoe', '>=2.7'
  ENV['RUBY_FLAGS'] = ""
  require 'echoe'

  Echoe.new('ambitious-sphinx') do |p|
    p.dependencies  << 'ultrasphinx >=1.7'
    p.summary        = 'An ambitious adapter for sphinx'
    p.author         = 'Josh Nichols'
    p.email          = 'josh@technicalpickles.com'

    p.project        = 'ambitioussphinx'
    p.url            = 'http://ambitioussphinx.rubyforge.org/'
    p.test_pattern   = 'test/*_test.rb'
    p.version        = '0.1.1'
    p.dependencies  << 'ambition >=0.5.2'
  end

rescue LoadError 
  puts "Not doing any of the Echoe gemmy stuff, because you don't have the specified gem versions"
end

desc 'Install as a gem'
task :install_gem do
  puts `rake manifest package && gem install pkg/ambitious-sphinx-#{Version}.gem`
end
