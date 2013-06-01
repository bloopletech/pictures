class Picture < Item
  def preview_path(force = false)
    preview_path = Pictures.previews_dir + "#{relative_path_from(Pictures.dir)}.jpg"
    if !preview_path.exist? || force
      begin
        preview_path.dirname.descend { |p| p.mkdir unless p.exist? }
        `convert #{File.escape_name("#{self}[0]")} -geometry '172x172^' +repage -gravity Center -crop '172x172+0+0' +repage -quality 50 #{File.escape_name(preview_path.to_s)}`
      rescue Exception => e
        Rails.logger.debug("#{e.message}\n#{e.backtrace}")
      end
    end
    preview_path
  end
  memoize :preview_path

  def preview_url
    "/system/previews/#{preview_path.relative_path_from(Pictures.previews_dir)}"
  end
  memoize :preview_url

#  acts_as_taggable

=begin
  def open
    increment!(:opens)
    update_attribute(:last_opened_at, DateTime.now)
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
