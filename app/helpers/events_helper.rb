module EventsHelper
  def display_uploaded_file(file)
    extension = file.to_s.split('.').last.try(:downcase)
    if extension == 'pdf'
      
      content_tag(:a, href: file, class: 'image-link') do image_tag('pdf-icon.png') end
    elsif extension.in?(['png','jpg','gif','jpeg'])
      content_tag(:a, href: file, class: 'image-link') do image_tag(file.thumb) end
    else
        'Tiada Fail Dijumpai'
    end
  end

  def display_rsvp_status(rsvp)
    case rsvp
    when nil
      'Belum Jawab'
    when true
      'Datang'
    when false
      'Tidak Datang'
    end
  end
end
