require 'ambition'

# stub out rails stuff enough so that ultrasphinx will be happy
RAILS_ROOT = "./" unless defined? RAILS_ROOT 
RAILS_ENV = "development" unless defined? RAILS_ENV

require 'active_record'
require 'ultrasphinx'

module Ambition::Adapters
  module AmbitiousSphinx
  end
end

%w(base page query select sort slice).each do |f|
  require "ambition/adapters/ambitious_sphinx/#{f}"
end

ActiveRecord::Base.extend Ambition::API
ActiveRecord::Base.ambition_adapter = Ambition::Adapters::AmbitiousSphinx

