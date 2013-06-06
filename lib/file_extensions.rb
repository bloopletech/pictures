class File
  IMAGE_EXTS = %w(.png .jpg .jpeg .gif)
  VIDEO_EXTS = %w(.avi .mkv .mp4 .mpg .ogm .wmv .flv)

  def self.image?(filename)
    IMAGE_EXTS.include?(File.extname(filename).downcase)
  end

  def self.video?(filename)
    VIDEO_EXTS.include?(File.extname(filename).downcase)
  end
end
