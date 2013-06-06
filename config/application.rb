require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

require 'fileutils'

#ActsAsTaggableOn.delimiter = ' '

Time::DATE_FORMATS.merge!(:default => '%e %B %Y') #TODO fix so shows time as well
Date::DATE_FORMATS.merge!(:default => '%e %B %Y')

require File.dirname(__FILE__) + '/../lib/system_static_middleware'

module Pictures
  class Application < Rails::Application
    config.middleware.insert_before ::ActionDispatch::Static, ::Pictures::SystemStaticMiddleware

    config.encoding = "utf-8"

    config.filter_parameters += [:password]
  end

  mattr_accessor :dir, :previews_dir
end

require Rails.root.join('lib/file_extensions')
require Rails.root.join('lib/directories')
