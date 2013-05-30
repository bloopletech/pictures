class PicturePreviewUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def root
    CarrierWave.root
  end

  def store_dir
    "system/previews/#{model.id}"
  end

  #note that since model.id will be nil this will end up being ..//tmp, which the system handles nicely
  def cache_dir
    "#{store_dir}/tmp"
  end

  version :thumbnail do
    process :thumbify => %w(PREVIEW_WIDTH PREVIEW_HEIGHT)
    version :small do
      process :thumbify => %w(PREVIEW_SMALL_WIDTH PREVIEW_SMALL_HEIGHT)
    end
  end

  def thumbify(p_width_const, p_height_const)
    manipulate! do |img|
      p_width = model.class.const_get(p_width_const)
      p_height = model.class.const_get(p_height_const)
      img = handle_image(img, p_width, p_height)
      img.page = Magick::Rectangle.new(img.columns, img.rows, 0, 0)
      img = img.extent(p_width, p_height, 0, 0)
      img.excerpt!(0, 0, p_width, p_height)

      img
    end
  end

  def handle_image(img, p_width, p_height)
    img.change_geometry!("#{p_width}>") { |cols, rows, _img| _img.resize!(cols, rows) }

    img
  end
end
