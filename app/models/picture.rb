class Picture < Item
  def preview_path(force = false)
    preview_path = Pictures.previews_dir + "#{relative_path_from(Pictures.dir)}.jpg"
    if !preview_path.exist? || force
      begin
        preview_path.dirname.descend { |p| p.mkdir unless p.exist? }
        `convert #{"#{self}[0]".shellescape} -geometry '198x198^' +repage -gravity Center -crop '198x198+0+0' +repage -quality 50 -strip #{preview_path.to_s.shellescape}`
      rescue Exception => e
        Rails.logger.debug("#{e.message}\n#{e.backtrace}")
      end
    end
    preview_path
  end
  memoize :preview_path

  def preview_url
    "/previews/#{preview_path.relative_path_from(Pictures.previews_dir)}"
  end
  memoize :preview_url

  def Picture?
    true
  end

#  acts_as_taggable

=begin
  def open
    increment!(:opens)
    update_attribute(:last_opened_at, DateTime.now)
  end

  def self.sort_key(title)
    title.gsub(/[^A-Za-z0-9]+/, '').downcase
  end
=end
end
