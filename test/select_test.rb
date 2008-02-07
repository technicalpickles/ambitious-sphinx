require File.dirname(__FILE__) + '/helper'

context 'AmbitiousSphinx Adapter :: Select' do
  
  specify 'Ruby attributes become Sphinx fields prefixed with @' do
    query = User.select {|m| m.name}.to_hash[:query]
    query.should == "name:"
  end
  
  specify 'Ruby string becomes Sphinx string' do
    query = User.select {'jon'}.to_hash[:query]
    query.should == %Q("jon")
  end
  
  specify 'Ruby string becomes Sphinx phrase search' do
    query = User.select {'jon doe'}.to_hash[:query]
    query.should == "\"jon doe\""
  end

  specify 'Ruby == should not be supported' do
    should.raise do User.select {|m| m.name == 'jon'} end
  end

  specify 'Ruby != becomes Sphinx NOT operator' do
    should.raise do User.select {|m| m.name != 'jon'} end
  end
  
  specify 'Ruby && becomes Sphinx AND operator' do
    query = User.select {'jon' && 'blarg'}.to_hash[:query]
    query.should == %Q("jon" AND "blarg")
  end

  specify 'Ruby || becomes Sphinx OR operator' do
    query = User.select { 'jon' || 'chris'}.to_hash[:query]
    query.should == %Q("jon" OR "chris")
  end

  specify 'Ruby =~ with string' do
    query = User.select {|m| m.name =~ 'chris'}.to_hash[:query]
    query.should == %Q(name:"chris")
  end
  
  specify 'Ruby =~ with string' do
    query = User.select {|m| m.name =~ 'chris' && m.name =~ 'jon'}.to_hash[:query]
    query.should == %Q(name:"chris" AND name:"jon")
  end
  
  specify 'Ruby =~ with Regexp' do
    should.raise do User.select {|m| m.name =~ /chris/} end
  end

  specify 'Ruby !~ with string' do
    query = User.select {|m| m.name =~ 'chris' && m.name !~ 'jon'}.to_hash[:query]
    query.should == %Q(name:"chris" AND NOT name:"jon")
  end
  
  specify 'Ruby !~ with Regexp is not supported' do
    should.raise do User.select {|m| m.name !~ /chris/} end
  end

  xspecify 'downcase' do
    translator = User.select {|m| m.name.downcase =~ 'chris'}
    translator.to_s.should == %Q(foo)
  end

  xspecify 'upcase' do
    translator = User.select {|m| m.name.upcase =~ 'chris%'}
    translator.to_s.should == %Q(foo)
  end

  xspecify 'undefined equality symbol' do
    should.raise do User.select {|m| m.name =* /chris/} end
  end

  xspecify 'block variable / assigning variable conflict' do
    m = User.select {|m| m.name == 'chris'}
    m.should == %Q(foo)
  end
  
  xspecify '== with inline ruby' do
    translator = User.select { |m| m.created_at == Time.now.to_s }
    translator.to_s.should == %Q(foo)
  end
  
  specify 'Ruby > should not be supported' do
    should.raise do User.select {|m| m.age > 21} end
  end
  
  specify 'Ruby >= should not be supported' do
    should.raise do User.select {|m| m.age >= 21} end
  end
  
  specify 'Ruby < should not be supported' do
    should.raise do User.select {|m| m.age < 21} end
  end
  
  specify 'Ruby <= should not be supported' do
    should.raise do User.select {|m| m.age <= 21} end
  end
  
  xspecify 'inspect' do
    User.select { |u| u.name }.inspect.should.match %r(call #to_s or #to_hash)
  end
end
