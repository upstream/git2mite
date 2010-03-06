require File.dirname(__FILE__) + '/spec_helper'
require 'git2mite/mite_client'

describe Git2Mite::MiteClient do
  describe "get" do
    before :each do
      @mite_client = Git2Mite::MiteClient.new 'http://example.org', 'api_key' 
    end
    
    it "should stringify the response for compatibility" do
      response = stub
      RestClient.stub :get => response
      JSON.stub :parse
      response.should_receive :to_s
      
      @mite_client.get '/test'
    end
  end
end