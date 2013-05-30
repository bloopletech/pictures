require 'rack/utils'

=begin
class Rack::File
  def _call(env)
    @path_info = Rack::Utils.unescape(env["PATH_INFO"])
    #Potential security issue if clients are untrusted

    @path = F.join(@root, @path_info)
    
    begin
      if F.file?(@path) && F.readable?(@path)
        serving
      else
        raise Errno::EPERM
      end
    rescue SystemCallError
      not_found
    end
  end
end
=end

module Pictures
  class SystemStaticMiddleware
    FILE_METHODS = %w(GET HEAD).freeze
    PREVIEWS_REGEX = /^\/system\/previews\//
    PICTURES_REGEX = /^\/p\//

    def initialize(app)
      @app = app
      @file_server = ::Rack::File.new('.')
    end

    def call(env)
      path   = ::Rack::Utils.unescape(env['PATH_INFO']).chomp('/')
      method = env['REQUEST_METHOD']

      if FILE_METHODS.include?(method) && path =~ PREVIEWS_REGEX
        @file_server.root = Pictures.previews_dir
        env['PATH_INFO'] = ::Rack::Utils.escape(path.gsub(PREVIEWS_REGEX, ""))
      elsif FILE_METHODS.include?(method) && path =~ PICTURES_REGEX
        @file_server.root = Pictures.dir.path
        env['PATH_INFO'] = ::Rack::Utils.escape(path.gsub(PICTURES_REGEX, ""))
      else
        return @app.call(env)
      end

      return @file_server.call(env)
    end
  end
end
