class WkhtmlImageExecutable
  attr_reader :system_platform

  def initialize(args={})
    @system_platform = args[:system_platform] || default_platform
  end

  def default_platform
    RUBY_PLATFORM
  end

  def binary_wkhtmltoimage
    case @system_platform
    when /x86_64-linux/
      'wkhtmltoimage-amd64'
    when /linux/
      'wkhtmltoimage-linux-i386-0.10.0'
    when /darwin/
      'wkhtmltoimage-osx-i386-0.10.0'
    else
      raise "No bundled binaries found for your system. Please install wkhtmltopdf."
    end
  end
end


