module WebSnap
  class Snapper
  
    class NoExecutableError < StandardError
      def initialize
        super('Could not locate wkhtmltoimage-proxy executable')
      end
    end
  
    class ImproperSourceError < StandardError
      def initialize(msg)
        super("Improper Source: #{msg}")
      end
    end
  
    attr_accessor :source, :stylesheets
    attr_reader :options
  
    def initialize(url_file_or_html, options={})
      @source = Source.new(url_file_or_html)
    
      @stylesheets = []

      default_options = {
        :'crop-h' => '768',
        :'crop-w' => '1024',
        :'crop-x' => '0',
        :'crop-y' => '0',
        :'format' => 'jpg'
      }
      @options = normalize_options(default_options.merge(options))
    
      raise NoExecutableError.new if wkhtmltoimage.nil? || wkhtmltoimage == ''
    end
  
    def command
      args = [wkhtmltoimage]
      args += @options.to_a.flatten.compact
    
      if @source.html?
        args << '-' # Get HTML from stdin
      else
        args << @source.to_s
      end
    
      args << '-' # Read PDF from stdout
      args.join(' ')
    end
  
    def to_bytes
      img = IO.popen(command, "w+")
      img.puts(@source.to_s) if @source.html?
      img.close_write
      result = img.gets(nil)
      img.close_read
      return result
    end
  
    def to_file(path)
      File.open(path,'w') {|file| file << self.to_bytes}
    end
  
    protected
  
      def wkhtmltoimage
        @wkhtmltoimage ||= `which wkhtmltoimage-proxy`.chomp
      end
  
      def normalize_options(options)
        normalized_options = {}
        options.each do |key, value|
          next if !value
          normalized_key = "--#{normalize_arg key}"
          normalized_options[normalized_key] = normalize_value(value)
        end
        normalized_options
      end
    
      def normalize_arg(arg)
        arg.to_s.downcase.gsub(/[^a-z0-9]/,'-')
      end
    
      def normalize_value(value)
        case value
        when TrueClass
          nil
        when String
          value.match(/\s/) ? "\"#{value}\"" : value
        else
          value
        end
      end
  
  end
end