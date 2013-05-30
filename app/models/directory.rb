class Directory < Item
  def preview_url
    "/images/directory.png"
#    "/system/previews/d/directory.png"
  end

  def children
    @children ||= directories + pictures
  end

  def directories
    @directories ||= Dir.glob("#{@path}/*/").map { |e| Directory.new(e.gsub(/\/$/, "")) }
  end

  def pictures
    @pictures ||= Dir.glob("#{@path}/*{#{File::IMAGE_EXTS.join(",")}}").map { |e| Picture.new(e) }
  end

  def reload
    @children = nil
    @directories = nil
    @pictures = nil
  end
end
