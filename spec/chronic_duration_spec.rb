require File.dirname(__FILE__) + '/spec_helper'

describe ChronicDuration, 'gem' do
  
  it "should build" do
    spec = eval(File.read("#{File.dirname(__FILE__)}/../chronic_duration.gemspec"))
    FileUtils.rm_f(File.dirname(__FILE__) + "/../chronic_duration-#{spec.version}.gem")
    system "cd #{File.dirname(__FILE__)}/.. && gem build chronic_duration.gemspec -q --no-verbose"
    File.exists?(File.dirname(__FILE__) + "/../chronic_duration-#{spec.version}.gem").should be_true
    FileUtils.rm_f(File.dirname(__FILE__) + "/../chronic_duration-#{spec.version}.gem")
  end
  
end

describe ChronicDuration, '.parse' do
  
  @exemplars = { 
    '1:20'          => 60 + 20,
    '1:20.51'       => 60 + 20.51,
    '4:01:01'       => 4 * 3600 + 60 + 1,
    '3 mins 4 sec'  => 3 * 60 + 4,
    '2 hrs 20 min'  => 2 * 3600 + 20 * 60,
    '2h20min'       => 2 * 3600 + 20 * 60
  }
  
  it "should raise a canned error if the parsing fails" do
    lambda { ChronicDuration.parse('gobblygoo') }.should raise_error
    lambda { ChronicDuration.parse('4 hours 20 minutes') }.should_not raise_error
  end
  
  it "should return a float if seconds are in decimals" do
    pending
  end
  
  it "should return an integer unless the seconds are in decimals" do
    pending
    
  end
  
  @exemplars.each do |k,v|
    it "should properly parse a duration like #{k}" do
      pending
      ChronicDuration.parse(k).should == v
    end
  end
  
end

# Some of the private methods deserve some spec'ing to aid
# us in development...

describe ChronicDuration, "private methods" do
  
  describe "#filter_by_type" do
    
    it "should take a chrono-formatted time like 3:14 and return a human time like 3 minutes 14 seconds" do
      ChronicDuration.instance_eval("filter_by_type('3:14')").should == '3 minutes 14 seconds'
    end
    
    it "should take a chrono-formatted time like 12:10:14 and return a human time like 12 hours 10 minutes 14 seconds" do
      ChronicDuration.instance_eval("filter_by_type('12:10:14')").should == '12 hours 10 minutes 14 seconds'
    end
    
    it "should return the input if it's not a chrono-formatted time" do
      ChronicDuration.instance_eval("filter_by_type('4 hours')").should == '4 hours'
    end
  
  end
  
  describe "#cleanup" do
    
    it "should clean up extraneous words" do
      ChronicDuration.instance_eval("cleanup('4 days and 11 hours')").should == '4 days 11 hours'
    end
    
    it "should cleanup extraneous spaces" do
      ChronicDuration.instance_eval("cleanup('  4 days and 11     hours')").should == '4 days 11 hours'
    end
    
    it "should insert spaces where there aren't any" do
      ChronicDuration.instance_eval("cleanup('4m11.5s')").should == '4 minutes 11.5 seconds'
    end
    
  end
  
end 