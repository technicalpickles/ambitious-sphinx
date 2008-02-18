require File.dirname(__FILE__) + '/helper'

context "AmbitiousSphinx Adapter :: Slice" do
  setup do
    @klass = User
    @block = @klass.select { |m| m.name =~ 'jon' }
  end
  
  specify "not supported" do
    should.raise {@block.first}
  end
end
