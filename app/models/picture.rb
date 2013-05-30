class Picture < Item
  def preview_url
    @preview_url ||= "/system/previews#{url}.jpg"

    preview_path = "#{Pictures.previews_dir}#{url}.jpg"
    if !File.exists?(preview_path)
      begin
        FileUtils.mkdir_p(File.dirname(preview_path))
        img = Magick::ImageList.new(path)
        p_width = 172
        p_height = 172
        img.change_geometry!("#{p_width}x#{p_height}^") { |cols, rows, _img| _img.resize!(cols, rows) }
        img.page = Magick::Rectangle.new(img.columns, img.rows, 0, 0)
        img = img.extent(p_width, p_height, 0, 0)
        img.excerpt!(0, 0, p_width, p_height)

        img.write(preview_path)
      rescue Exception => e
        Rails.logger.debug("#{e.message}\n#{e.backtrace}")
      end
    end

    @preview_url
  end

  def direct_url
    "/system#{url}"
  end

#  acts_as_taggable

#  mount_uploader :preview, ItemPreviewUploader
=begin
  def real_path
    File.expand_path("#{Pictures.send("#{self.class.name.underscore.pluralize}_dir")}/#{path}")
  end

  def open
    increment!(:opens)
    update_attribute(:last_opened_at, DateTime.now)
  end

  def delete_original
    begin
      FileUtils.mkdir_p(File.dirname("#{Pictures.deleted_dir}/#{path}"))
      File.rename(real_path, "#{Pictures.deleted_dir}/#{path}")
    rescue Exception => e
      ActionDispatch::ShowExceptions.new(Pictures::Application.instance).send(:log_error, e)
      return
    end
  end

  def export
    begin
      FileUtils.mkdir_p(File.dirname("#{Pictures.exported_dir}/#{path}"))
      FileUtils.cp_r(real_path, "#{Pictures.exported_dir}/#{path}")
    rescue Exception => e
      ActionDispatch::ShowExceptions.new(Pictures::Application.instance).send(:log_error, e)
      return
    end
  end

  def self.sort_key(title)
    title.gsub(/[^A-Za-z0-9]+/, '').downcase
  end
=end

end
