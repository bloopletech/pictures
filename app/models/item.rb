require "digest/md5"

class Item
  extend ActiveModel::Naming

  def initialize(path)
    @path = path
  end

  def self.from_url(url)
    raise "Invalid URL" if url.nil? || url.length < 2 || url[0..0] != "/"

    klass = case url[1..1]
    when "d"
      Directory
    when "p"
      Picture
    else
      raise "Invalid URL"
    end
    klass.new("#{Pictures.dir.path}#{url[2..-1]}")
  end

  def self.from_url_path(url_path)
    self.new("#{Pictures.dir.path}#{url_path.blank? ? "" : "/#{url_path}"}")
  end

  attr_reader :path

  def url
    @url ||= "/#{self.class.to_s[0..0].downcase}#{@path.gsub(/^#{Regexp.escape Pictures.dir.path}/, "")}"
  end

  def filename
    @filename ||= File.basename(path)
  end

  def to_key
    @to_key ||= [Digest::MD5.hexdigest(url)]
  end

  def opens
    0
  end

  def pages
    0
  end
end
