require 'item_preview_uploader'
#require 'video_preview_uploader'

class Video < Item
  PREVIEW_WIDTH = 418
  PREVIEW_HEIGHT = 314  
  
  def self.import_and_update
    #Requires GNU find 3.8 or above
    cmd = <<-CMD
cd #{File.escape_name(Mangar.dir)} && find . -depth \\( -type f \\( #{File::VIDEO_EXTS.map { |ext| "-iname '*#{ext}'" }.join(' -o ')} \\) \\)
CMD
puts "cmd: #{cmd.inspect}"

    $stdout.puts #This makes it actually import; fuck knows why

    path_list = IO.popen(cmd) { |s| s.read }
    path_list = path_list.split("\n").map { |e| e.gsub(/^\.\//, '') }.reject { |e| e[0, 1] == '.' }

    path_list.each { |path| self.import(path) }
  end

  def self.import(relative_path)    
    real_path = File.expand_path("#{Mangar.dir}/#{relative_path}")
    destination_path = File.expand_path("#{Mangar.videos_dir}/#{relative_path}")
    
    last_modified = File.mtime(real_path)
    preview = nil

    begin
      FileUtils.mkdir_p(File.dirname(destination_path))
      File.rename(real_path, destination_path)
      preview = Video.preview_from_video_file(destination_path)
    rescue Exception => e
      ActionDispatch::ShowExceptions.new(Mangar::Application.instance).send(:log_error, e)
      return
    end

    title = File.basename(relative_path).gsub(/\.#{File::VIDEO_EXTS.join('|')}/, '').gsub(/_/, ' ')    
    Video.create!(:title => title, :path => relative_path, :published_on => last_modified, :preview => preview, :pages => 0,
     :sort_key => Item.sort_key(title))

    #FileUtils.rm_r(real_path) if File.exists?(real_path)
  end

  def self.preview_from_video_file(real_path)
    frame_filename = "#{Dir.tmpdir}/#{ActiveSupport::SecureRandom.hex(20)}.png"
    system("totem-video-thumbnailer -r #{File.escape_name(real_path)} #{File.escape_name(frame_filename)}")
    raise "Couldn't thumbnail #{real_path}" unless File.exists?(frame_filename)
    at_exit { File.delete(frame_filename) if File.exists?(frame_filename) }    
    return File.open(frame_filename)
  end
end