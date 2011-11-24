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
  
    def to_file(path, image_path=nil)
      append_stylesheets
      @source = Source.new(@source.to_s.gsub(/images\//, image_path)) unless image_path.nil?
      File.open(path,'w') {|file| file << self.to_bytes}
    end
  
    def append_stylesheets
      raise ImproperSourceError.new('Stylesheets may only be added to an HTML source') if stylesheets.any? && !@source.html?

      stylesheets.each do |stylesheet|
        if @source.to_s.match(/<\/head>/)
          @source = Source.new(@source.to_s.gsub(/(<\/head>)/, style_tag_for(stylesheet)+'\1'))
        else
          @source.to_s.insert(0, style_tag_for(stylesheet))
        end
      end
    end
  
    def style_tag_for(stylesheet)
      "<style>#{File.read(stylesheet)}</style>"
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