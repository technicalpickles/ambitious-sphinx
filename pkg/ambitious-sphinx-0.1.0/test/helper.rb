%w( rubygems test/spec mocha redgreen English ).each { |f| require f }

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'ambition/adapters/ambitious_sphinx'

class User < ActiveRecord::Base 
  attr_reader :name
  attr_reader :age
end