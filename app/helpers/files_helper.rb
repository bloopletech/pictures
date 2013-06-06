module FilesHelper
#  include ActsAsTaggableOn::TagsHelper

  def is_last_page?(collection)
    collection.total_pages == 0 || (collection.total_pages == (params[:page].blank? ? 1 : params[:page].to_i))
  end

  def files_with(new_params)
    files_path(params.except(:controller, :action, :page).merge(new_params))
  end

  def wbrize(str)
    str
#    raw str.split(' ').map { |sub_str| sub_str.split(/(.{,15})/).map { |s| h s }.join("<wbr>") }.join(' ')
  end

  def file_title(file, show)
    raw (show ? "<div class='title'>#{h wbrize(truncate(file.title, :length => 80))}</div>" : "")
  end

  def selector(name, options)
    out = %Q{<ul class="selector" data-name="#{name}">}
    options.each do |(description, value)|
      out << %Q{<li data-value="#{value}"#{params[name] == value ? " class='selected'" : ""}>#{link_to(description, files_path(name.to_sym => value))}</li>}
    end
    out << %Q{</ul>}
    out << hidden_field_tag(name, params[name])
    raw out
  end
end
