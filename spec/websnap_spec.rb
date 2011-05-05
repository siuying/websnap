require 'spec_helper'

describe WebSnap::Snapper do
  
  context "initialization" do
    it "should accept HTML as the source" do
      websnap = WebSnap::Snapper.new('<h1>Oh Hai</h1>')
      websnap.source.should be_html
      websnap.source.to_s.should == '<h1>Oh Hai</h1>'
    end
    
    it "should accept a URL as the source" do
      websnap = WebSnap::Snapper.new('http://google.com')
      websnap.source.should be_url
      websnap.source.to_s.should == 'http://google.com'
    end
    
    it "should accept a File as the source" do
      file_path = File.join(SPEC_ROOT,'fixtures','google.html')
      websnap = WebSnap::Snapper.new(File.new(file_path))
      websnap.source.should be_file
      websnap.source.to_s.should == file_path
    end
    
    it "should parse the options into a cmd line friedly format" do
      websnap = WebSnap::Snapper.new('html', :'crop-w' => '800', :'crop-h' => '600')
      websnap.options.should have_key('--crop-w')
    end

    it "should provide default options" do
      websnap = WebSnap::Snapper.new('<h1>Oh Hai</h1>')
      ['--crop-w', '--crop-h', '--scale-w', '--scale-h', '--format'].each do |option|
        websnap.options.should have_key(option)
      end
    end
  end
  
  context "command" do
    it "should contstruct the correct command" do
      websnap = WebSnap::Snapper.new('html', :'encoding' => 'Big5')
      websnap.command.should include('--encoding Big5')
    end

    it "read the source from stdin if it is html" do
      websnap = WebSnap::Snapper.new('html')
      websnap.command.should match(/ - -$/)
    end
    
    it "specify the URL to the source if it is a url" do
      websnap = WebSnap::Snapper.new('http://google.com')
      websnap.command.should match(/ http:\/\/google\.com -$/)
    end
    
    it "should specify the path to the source if it is a file" do
      file_path = File.join(SPEC_ROOT,'fixtures','google.html')
      websnap = WebSnap::Snapper.new(File.new(file_path))
      websnap.command.should match(/ #{file_path} -$/)
    end
  end
  
  context "#to_bytes" do
    it "should generate a PDF of the HTML" do
      websnap = WebSnap::Snapper.new('html')
      websnap.expects(:to_bytes).returns('PNG')
      png = websnap.to_bytes
      png.should match(/PNG/)
    end
  end
  
  context "#to_file" do
    before do
      @file_path = File.join(SPEC_ROOT,'fixtures','test.png')
      File.delete(@file_path) if File.exist?(@file_path)
    end
    
    after do
      File.delete(@file_path)
    end
    
    it "should create a file with the PNG as content" do
      websnap = WebSnap::Snapper.new('html')
      websnap.expects(:to_bytes).returns('PNG')

      file = websnap.to_file(@file_path)
      file.should be_instance_of(File)
      File.read(file.path).should == 'PNG'
    end
  end
  
end
