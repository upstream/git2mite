require File.dirname(__FILE__) + '/spec_helper'
require 'git_repo'


describe GitRepo do
  describe "commits" do
    before(:each) do
      @today = Date.today
    end
    it "should strip newlines on authors" do
      IO.stub(:popen).and_yield(StringIO.new("2009-11-04 19:11:38 +0100|updated readme to include example how to run git2mite|thilo@upstream-berlin.com\n"))
      GitRepo.new.commits(@today, @today).first[2].should == "thilo@upstream-berlin.com"
    end
  end
end
