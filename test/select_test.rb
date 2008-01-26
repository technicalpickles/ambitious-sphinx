require File.dirname(__FILE__) + '/helper'

context "ruby's && operator is translated to sphinx's & operator" do
  setup do
    @klass = User
  end

  specify "when using fields with ==" do
    q = @klass.select { |m| m.name == 'jon' && m.age == 21 }.to_hash[:query]
    q.to_s.should == %Q(@name jon & @age 21)
  end

  specify "when using strings without fields" do
    query = @klass.select {'jon' && 'blarg'}.to_hash[:query]
    query.should == %Q(jon & blarg)
  end
end

context "AmbitiousSphinx Adapter :: Select" do
  setup do
    @klass = User
  end
  
  # FIXME why doesn't this work?
  def do_select(block)
    hash = @klass.select { block.call }.to_hash
    hash[:query]
  end
  
  specify "string" do
    query = @klass.select { 'jon' }.to_hash[:query]
    query.should == %Q(jon)
  end

  specify "==" do
    query = @klass.select { |m| m.name == 'jon' }.to_hash[:query]
    query.should == %Q(@name jon)
  end

  specify "!=" do
    query = @klass.select { |m| m.name != 'jon' }.to_hash[:query]
    query.to_s.should == %Q(@name -jon)
  end

  specify "== || ==" do
    query = @klass.select { |m| m.name == 'jon' || m.age == 21 }.to_hash[:query]
    query.should == %Q(@name jon | @age 21)
  end
  
  specify "string || string" do
    query = @klass.select { 'jon' || 21 }.to_hash[:query]
    query.should == %Q(jon | 21)
    
  end

  xspecify "mixed && and ||" do
    translator = @klass.select { |m| m.name == 'jon' || m.age == 21 && m.password == 'pass' }
    translator.to_s.should == %Q(foo)
  end

  # xspecify "grouped && and ||" do
  #     translator = @klass.select { |m| (m.name == 'jon' || m.name == 'rick') && m.age == 21 }
  #     translator.to_s.should == %Q(foo)
  #   end

  xspecify "array.include? item" do
    translator = @klass.select { |m| [1, 2, 3, 4].include? m.id }
    translator.to_s.should == %Q(foo)
  end

  xspecify "variabled array.include? item" do
    array = [1, 2, 3, 4]
    translator = @klass.select { |m| array.include? m.id }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with variables" do
    me = 'chris'
    translator = @klass.select { |m| m.name == me }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with method arguments" do
    def test_it(name)
      translator = @klass.select { |m| m.name == name }
      translator.to_s.should == %Q(foo)
    end

    test_it('chris')
  end

  xspecify "== with instance variables" do
    @me = 'chris'
    translator = @klass.select { |m| m.name == @me }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with instance variable method call" do
    require 'ostruct'
    @person = OpenStruct.new(:name => 'chris')

    translator = @klass.select { |m| m.name == @person.name }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with global variables" do
    $my_name = 'boston'
    translator = @klass.select { |m| m.name == $my_name }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with method call" do
    def band
      'skinny puppy'
    end

    translator = @klass.select { |m| m.name == band }
    translator.to_s.should == %Q(foo)
  end

  xspecify "=~ with string" do
    translator = @klass.select { |m| m.name =~ 'chris' }
    translator.to_s.should == %Q(foo)
  end

  xspecify "!~ with string" do
    translator = @klass.select { |m| m.name !~ 'chris' }
    translator.to_s.should == %Q(foo)

    translator = @klass.select { |m| !(m.name =~ 'chris') }
    translator.to_s.should == %Q(foo)
  end

  xspecify "=~ with regexp" do
    should.raise { @klass.select { |m| m.name =~ /chris/ } }
  end

  xspecify "=~ with regexp flags" do
    should.raise { @klass.select { |m| m.name =~ /chris/i } }
  end

  xspecify "downcase" do
    translator = @klass.select { |m| m.name.downcase =~ 'chris' }
    translator.to_s.should == %Q(foo)
  end

  xspecify "upcase" do
    translator = @klass.select { |m| m.name.upcase =~ 'chris%' }
    translator.to_s.should == %Q(foo)
  end

  xspecify "undefined equality symbol" do
    should.raise { @klass.select { |m| m.name =* /chris/ } }
  end

  xspecify "block variable / assigning variable conflict" do
    m = @klass.select { |m| m.name == 'chris' }
    m.should == %Q(foo)
  end
  
  xspecify "== with inline ruby" do
    translator = @klass.select { |m| m.created_at == Time.now.to_s }
    translator.to_s.should == %Q(foo)
  end

  xspecify "inspect" do
    @klass.select { |u| u.name }.inspect.should.match %r(call #to_s or #to_hash)
  end
end
