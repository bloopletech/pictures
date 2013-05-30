class MoveBookImages < ActiveRecord::Migration
  def self.up
    FileUtils.mv("#{Pictures.mangar_dir}/public/system/books", "#{Pictures.mangar_dir}/public/system/book_previews") if File.exists?("#{Pictures.mangar_dir}/public/system/books")
    FileUtils.mv("#{Pictures.mangar_dir}/public/system/book_images", "#{Pictures.mangar_dir}/public/system/books") if File.exists?("#{Pictures.mangar_dir}/public/system/book_images")    
  end

  def self.down    
    #FileUtils.mv("#{Pictures.mangar_dir}/public/system/books", "#{Pictures.mangar_dir}/public/system/book_images") if File.exists?("#{Pictures.mangar_dir}/public/system/books")
    #FileUtils.mv("#{Pictures.mangar_dir}/public/system/book_previews", "#{Pictures.mangar_dir}/public/system/books") if File.exists?("#{Pictures.mangar_dir}/public/system/book_previews")
  end
end
