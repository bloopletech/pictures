require "digest/md5"

class Item < Pathname
  extend ActiveModel::Naming
  extend ActiveSupport::Memoizable

  def self.from_url_path(url_path)
    self.new(Pictures.dir + url_path)
  end

  def url
    "/#{self.class.to_s[0..0].downcase}/#{relative_path_from(Pictures.dir)}"
  end
  memoize :url

  def to_key
    [Digest::MD5.hexdigest(url)]
  end
  memoize :to_key

  def title
    basename.to_s
  end

  def opens
    0
  end

  def pages
    0
  end
end
