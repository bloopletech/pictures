class MoveVideoPreviews < ActiveRecord::Migration
  def self.up
    FileUtils.mv("#{Pictures.mangar_dir}/public/system/videos", "#{Pictures.mangar_dir}/public/system/video_previews") if File.exists?("#{Pictures.mangar_dir}/public/system/videos")
    FileUtils.mkdir("#{Pictures.mangar_dir}/public/system/videos") if !File.exists?("#{Pictures.mangar_dir}/public/system/videos")
  end

  def self.down
  end
end
