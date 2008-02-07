require File.dirname(__FILE__) + '/helper'

context "AmbitiousSphinx Adapter :: Sort" do
  setup do
    @klass = User
    @block = @klass.select { |m| m.name =~ 'jon' }
  end

  xspecify "order" do
    string = @block.sort_by { |m| m.name }.to_s
    string.should == "foo"
  end

  xspecify "combined order" do
    string = @block.sort_by { |m| [ m.name,  m.age ] }.to_s
    string.should == "foo"
  end

  xspecify "combined order with single reverse" do
    string = @block.sort_by { |m| [ m.name,  -m.age ] }.to_s
    string.should == "foo"
  end

  xspecify "combined order with two reverses" do
    string = @block.sort_by { |m| [ -m.name,  -m.age ] }.to_s
    string.should == "foo"
  end

  xspecify "reverse order with -" do
    string = @block.sort_by { |m| -m.age }.to_s
    string.should == "foo"
  end

  xspecify "reverse order with #reverse" do
    # TODO: not implemented
    string = @block.sort_by { |m| m.age }.reverse.to_s
    string.should == "foo"
  end

  xspecify "random order" do
    string = @block.sort_by { rand }.to_s
    string.should == "foo"
  end
  
  xspecify "non-existent method to sort by" do
    should.raise(NoMethodError) { @block.sort_by { foo }.to_s }
  end

  xspecify "Symbol#to_proc" do
    string = @klass.sort_by(&:name).to_s
    string.should == "foo"
  end
end
