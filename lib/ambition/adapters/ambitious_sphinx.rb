
require 'ambition'

RAILS_ROOT = "./" unless defined? RAILS_ROOT 
RAILS_ENV = "development" unless defined? RAILS_ENV

require 'active_record'
require 'ultrasphinx'
%w(base page query select sort slice).each do |base|
  require "ambition/adapters/ambitious_sphinx/#{base}"
end

##
# This is where you inject Ambition into your target.
#
# Use `extend' if you are injecting a class, `include' if you are
# injecting instances of that class.
#
# You must also set the `ambition_adapter' class variable on your target
# class, regardless of whether you are injecting instances or the class itself.
#
# You probably want something like this:
#
ActiveRecord::Base.extend Ambition::API
ActiveRecord::Base.ambition_adapter = Ambition::Adapters::AmbitiousSphinx