class Directory < Item
  def initialize(path, parent = false)
    super(path)
    @parent = parent
  end

  def preview_url
    "/images/directory.png"
#    "/system/previews/d/directory.png"
  end

  def directories
    load
    @directories
  end
  memoize :directories

  def pictures
    load
    @pictures
  end
  memoize :pictures

  def items
    directories + pictures
  end
  memoize :items

  def title
    if @parent
      ".."
    elsif self == Pictures.dir
      "Root"
    else
      super
    end
  end

  def load
    dirs, pics = children.reject { |p| p.basename.to_s =~ /^\./ }.partition { |p| p.directory? }

    @directories = dirs.sort_by { |d| d.basename.to_s.downcase }.map { |d| Directory.new(d) }
    @directories.unshift Directory.new(parent, true) unless self == Pictures.dir

    @pictures = pics.select { |p| File::IMAGE_EXTS.include?(p.extname) }.sort_by { |p| p.mtime }.map { |p| Picture.new(p) }
  end
end
