require File.dirname(__FILE__) + '/helper'

context "AmbitiousSphinx Adapter :: Slice" do
  setup do
    @klass = User
    @block = @klass.select { |m| m.name == 'jon' }
  end

  xspecify "first" do
    @klass.expects(:find).with(:limit => 1, :name => 'jon')
    @block.first
  end

  xspecify "first with argument" do
    @klass.expects(:find).with(:limit => 5, :name => 'jon')
    @block.first(5).entries
  end
  
  xspecify "[] with two elements" do
    @klass.expects(:find).with(:limit => 20, :offset => 10, :name => 'jon')
    @block[10, 20].entries

    @klass.expects(:find).with(:limit => 20, :offset => 20, :name => 'jon')
    @block[20, 20].entries
  end
  
  xspecify "slice is an alias of []" do
    @klass.expects(:find).with(:limit => 20, :offset => 10, :name => 'jon')
    @block.slice(10, 20).entries
  end
  
  xspecify "[] with range" do
    @klass.expects(:find).with(:limit => 10, :offset => 10, :name => 'jon')
    @block[11..20].entries
  end
end
