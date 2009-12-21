require File.dirname(__FILE__) + '/spec_helper'
require 'configuration'

describe Git2Mite::Configuration do
  before(:each) do
    @path = 'test_config.yml'
    File.unlink(@path) if File.exist?(@path)
  end
  
  after(:each) do
    File.unlink(@path) if File.exist?(@path)
  end
  
  it "should persist a value" do
    config = Git2Mite::Configuration.new(@path)
    config.api_key = '123'
    Git2Mite::Configuration.new(@path).api_key.should == '123'
  end
  
  it "should return the value on setting it" do
    returned = Git2Mite::Configuration.new(@path).api_key = '234'
    returned.should == '234'
  end
end