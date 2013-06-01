# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Pictures::Application.initialize!

#Pictures::Application::DATABASE_PATH = "#{Pictures.mangar_dir}/db.sqlite3"

#ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :pool => 5, :timeout => 5000, :database => Pictures::Application::DATABASE_PATH)
#ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate/")

Pictures.dir = Directory.new(Pathname.new("~/.pictures/").expand_path)

Pictures.previews_dir = Pictures.dir + ".previews"
Pictures.previews_dir.descend { |p| p.mkdir unless p.exist? }

#%w(open gnome-open).detect { |app| system("#{app} http://localhost:30813/") } unless $0 =~ /^rake|irb$/
