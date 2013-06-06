puts "task"
task :generate_previews => :environment do
  pictures = []

  append_list = proc do |dir|
    ps = dir.pictures
    puts "Appending #{ps.length} pictures from #{dir} to the list"
    pictures << ps
    dir.directories.each { |d| append_list.call(d) }
  end

  append_list.call(Pictures.dir)

  puts pictures.inspect
end
