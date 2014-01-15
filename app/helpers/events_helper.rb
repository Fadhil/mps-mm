module EventsHelper
  def display_uploaded_file(file)
    extension = file.to_s.split('.').last.try(:downcase).try(:split,'?').try(:first)
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
      'Akan Hadir'
    when false
      'Tidak Akan Hadir'
    end
  end

  def display_email_read_status(email_read)
    case email_read
    when nil
      'Belum Dibuka'
    when false
      'Belum Dibuka'
    when true
      'Sudah Dibuka'
    end
  end
end
