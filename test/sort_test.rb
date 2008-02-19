require File.dirname(__FILE__) + '/helper'

context "AmbitiousSphinx Adapter :: Sort" do
  setup do
    @klass = User
    @block = @klass.select { |m| m.name =~ 'jon' }
  end

  specify "order" do
    should.raise do
      @block.sort_by {|m| m.name}
    end
  end

  specify "reverse order with -" do
    should.raise do
       @block.sort_by { |m| -m.age }
     end
  end

  specify "random order" do
    should.raise do
      @block.sort_by { rand }
    end
  end
end
