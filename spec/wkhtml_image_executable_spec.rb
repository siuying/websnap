require 'spec_helper'
require_relative '../bin/wkhtml_image_executable'

describe WkhtmlImageExecutable do

  it "should return wkhtmltoimage-amd64 when platform contains 64-linux" do 
    WkhtmlImageExecutable.new({system_platform: "x86_64-linux"}).binary_wkhtmltoimage.should eq "wkhtmltoimage-amd64"
  end
  
  it "should return wkhtmltoimage-linux-i386-0.10.0 when platform contains linux" do 
    WkhtmlImageExecutable.new({system_platform: "linux"}).binary_wkhtmltoimage.should eq "wkhtmltoimage-linux-i386-0.10.0"
  end
  
  it "should return wkhtmltoimage-osx-i386-0.10.0 when platform contains darwin" do 
    WkhtmlImageExecutable.new({system_platform: "darwin"}).binary_wkhtmltoimage.should eq "wkhtmltoimage-osx-i386-0.10.0"
  end

  it "should raise execption when platform is not found with a matching " do
    expect {WkhtmlImageExecutable.new({system_platform: "magical_unicorns"}).binary_wkhtmltoimage}.to raise_error
  end
end

