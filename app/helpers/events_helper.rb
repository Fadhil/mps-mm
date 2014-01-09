module EventsHelper
  def display_uploaded_file(file)
    the_thumb = ''
    if file.to_s.split('.').last.downcase == 'pdf'
      
      content_tag(:a, href: file, class: 'image-link') do image_tag('pdf-icon.png') end
    else
      content_tag(:a, href: file, class: 'image-link') do image_tag(file.thumb) end
    end
  end

end
