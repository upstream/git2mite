require File.dirname(__FILE__) + '/spec_helper'
require 'gui'

describe Gui do
  describe "get date" do
    before(:each) do
      @gui = Gui.new
    end
    it "should use entered date" do
      $stdin = StringIO.new "2008-09-11" 
      date = @gui.get_date('start date')

      date.should == Date.parse('2008-09-11')
    end
    
    it "should use the current date if no date entered" do
      $stdin = StringIO.new "\n" 
      date = @gui.get_date('start date')
      date.should == Date.today
      
    end
  end
end
