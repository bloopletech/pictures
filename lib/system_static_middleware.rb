require 'rack/utils'

module Pictures
  class SystemStaticMiddleware
    FILE_METHODS = %w(GET HEAD).freeze

    def initialize(app)
      @app = app
      @file_server = ::Rack::File.new('.')
    end

    def call(env)
      path = ::Rack::Utils.unescape(env['PATH_INFO']).chomp('/')

      if FILE_METHODS.include?(env['REQUEST_METHOD']) && !path.blank?
        type, relative_path = path[1..-1].split("/", 2)
        @file_server.root = nil

        if type == "files" && relative_path && File.image?(relative_path)
          @file_server.root = Pictures.dir.to_s
        elsif type == "previews"
          @file_server.root = Pictures.previews_dir.to_s
        end

        if @file_server.root
          env['PATH_INFO'] = ::Rack::Utils.escape(relative_path)
          return @file_server.call(env)
        end
      end
      
      @app.call(env)
    end
  end
end
