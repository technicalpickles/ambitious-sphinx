require File.dirname(__FILE__) + '/helper'

context "AmbitiousSphinx Adapter :: Select" do
  
  context "Ruby && becomes Sphinx &" do    
    specify "when using fields with ==" do
      query = User.select { |m| m.name == 'jon' && m.age == 21 }.to_hash[:query]
      query.should == %Q(@name jon & @age 21)
    end

    specify "when using strings without fields" do
      query = User.select {'jon' && 'blarg'}.to_hash[:query]
      query.should == %Q(jon & blarg)
    end
  end

  context "Ruby || becomes Sphinx |" do
    specify "== || ==" do
      query = User.select { |m| m.name == 'jon' || m.age == 21 }.to_hash[:query]
      query.should == %Q(@name jon | @age 21)
    end

    specify "string || string" do
      query = User.select { 'jon' || 21 }.to_hash[:query]
      query.should == %Q(jon | 21)
    end
  end
  
  # FIXME why doesn't this work?
  def do_select(block)
    hash = User.select { block.call }.to_hash
    hash[:query]
  end
  
  specify "string" do
    query = User.select { 'jon' }.to_hash[:query]
    query.should == %Q(jon)
  end

  specify "==" do
    query = User.select { |m| m.name == 'jon' }.to_hash[:query]
    query.should == %Q(@name jon)
  end

  specify "!=" do
    query = User.select { |m| m.name != 'jon' }.to_hash[:query]
    query.to_s.should == %Q(@name -jon)
  end

  xspecify "mixed && and ||" do
    translator = User.select { |m| m.name == 'jon' || m.age == 21 && m.password == 'pass' }
    translator.to_s.should == %Q(foo)
  end

  # xspecify "grouped && and ||" do
  #     translator = User.select { |m| (m.name == 'jon' || m.name == 'rick') && m.age == 21 }
  #     translator.to_s.should == %Q(foo)
  #   end

  xspecify "array.include? item" do
    translator = User.select { |m| [1, 2, 3, 4].include? m.id }
    translator.to_s.should == %Q(foo)
  end

  xspecify "variabled array.include? item" do
    array = [1, 2, 3, 4]
    translator = User.select { |m| array.include? m.id }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with variables" do
    me = 'chris'
    translator = User.select { |m| m.name == me }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with method arguments" do
    def test_it(name)
      translator = User.select { |m| m.name == name }
      translator.to_s.should == %Q(foo)
    end

    test_it('chris')
  end

  xspecify "== with instance variables" do
    @me = 'chris'
    translator = User.select { |m| m.name == @me }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with instance variable method call" do
    require 'ostruct'
    @person = OpenStruct.new(:name => 'chris')

    translator = User.select { |m| m.name == @person.name }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with global variables" do
    $my_name = 'boston'
    translator = User.select { |m| m.name == $my_name }
    translator.to_s.should == %Q(foo)
  end

  xspecify "== with method call" do
    def band
      'skinny puppy'
    end

    translator = User.select { |m| m.name == band }
    translator.to_s.should == %Q(foo)
  end

  xspecify "=~ with string" do
    translator = User.select { |m| m.name =~ 'chris' }
    translator.to_s.should == %Q(foo)
  end

  xspecify "!~ with string" do
    translator = User.select { |m| m.name !~ 'chris' }
    translator.to_s.should == %Q(foo)

    translator = User.select { |m| !(m.name =~ 'chris') }
    translator.to_s.should == %Q(foo)
  end

  xspecify "=~ with regexp" do
    should.raise { User.select { |m| m.name =~ /chris/ } }
  end

  xspecify "=~ with regexp flags" do
    should.raise { User.select { |m| m.name =~ /chris/i } }
  end

  xspecify "downcase" do
    translator = User.select { |m| m.name.downcase =~ 'chris' }
    translator.to_s.should == %Q(foo)
  end

  xspecify "upcase" do
    translator = User.select { |m| m.name.upcase =~ 'chris%' }
    translator.to_s.should == %Q(foo)
  end

  xspecify "undefined equality symbol" do
    should.raise { User.select { |m| m.name =* /chris/ } }
  end

  xspecify "block variable / assigning variable conflict" do
    m = User.select { |m| m.name == 'chris' }
    m.should == %Q(foo)
  end
  
  xspecify "== with inline ruby" do
    translator = User.select { |m| m.created_at == Time.now.to_s }
    translator.to_s.should == %Q(foo)
  end

  xspecify "inspect" do
    User.select { |u| u.name }.inspect.should.match %r(call #to_s or #to_hash)
  end
end
