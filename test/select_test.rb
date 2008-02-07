require File.dirname(__FILE__) + '/helper'

context "AmbitiousSphinx Adapter :: Select" do
  
  specify "Ruby attributes become Sphinx fields prefixed with @" do
    query = User.select { |m| m.name }.to_hash[:query]
    query.should == "name:"
  end
  
  specify "Ruby string becomes Sphinx string" do
    query = User.select { 'jon' }.to_hash[:query]
    query.should == "jon"
  end
  
  xspecify "Ruby string becomes Sphinx phrase search" do
    query = User.select { 'jon doe' }.to_hash[:query]
    query.should == "\"jon doe\""
  end

  specify "Ruby == should not be supported" do
    should.raise { User.select { |m| m.name == 'jon' } }
  end

  specify "Ruby != becomes Sphinx NOT operator" do
    should.raise { User.select { |m| m.name != 'jon' } }
  end
  
  specify "Ruby && becomes Sphinx AND operator" do
    query = User.select { 'jon' && 'blarg' }.to_hash[:query]
    query.should == "jon AND blarg"
  end

  specify "Ruby || becomes Sphinx OR operator" do
    query = User.select { 'jon' || 21 }.to_hash[:query]
    query.should == "jon OR 21"
  end

  specify "Ruby String.include? becomes Sphinx field search operator" do
    query = User.select { |m| m.name.include? "jon" }.to_hash[:query]
    query.should == "name:jon"
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
  
  specify "Ruby > should not be supported" do
    should.raise { User.select { |m| m.age > 21 } }
  end
  
  specify "Ruby >= should not be supported" do
    should.raise { User.select { |m| m.age >= 21 } }
  end
  
  specify "Ruby < should not be supported" do
    should.raise { User.select { |m| m.age < 21 } }
  end
  
  specify "Ruby <= should not be supported" do
    should.raise { User.select { |m| m.age <= 21 } }
  end
  
  xspecify "inspect" do
    User.select { |u| u.name }.inspect.should.match %r(call #to_s or #to_hash)
  end
end
