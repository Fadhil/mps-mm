class InvitationMailer < ActionMailer::Base
  default from: "mps-mm@iedwrites.com"


  def send_invites(media_profile, event, attendee)
    
    @media_profile = media_profile
    @event = event
    @attendee = attendee
    emails = []
    emails << @media_profile.email
    emails << @media_profile.personal_email unless @media_profile.personal_email.blank?
    letter_extension = get_file_extension(@event.letter)
    agenda_extension = get_file_extension(@event.agenda_details)
    if Rails.env.development?
      attachments["lampiran.#{letter_extension.to_s}"] = File.read("#{Rails.root}/public#{@event.letter}") unless @event.letter.blank?
      attachments["agenda.#{agenda_extension.to_s}"] = File.read("#{Rails.root}/public#{@event.agenda_details}") unless @event.agenda_details.blank?
    elsif Rails.env.production?
      begin
        attachments["lampiran.#{letter_extension.to_s}"] = open(@event.letter.to_s).read unless @event.letter.blank?
        attachments["agenda.#{agenda_extension.to_s}"] = open(@event.agenda_details.to_s).read unless @event.agenda_details.blank?
      rescue => e
          Rails.logger.info "Failed to attachattachments. Error: #{e}\n"

      end
    end
    mail(to: emails, subject: "Anda dijemput ke acara #{@event.name}")

  end

  def get_file_extension(file)
    extension = file.to_s.split('.').last.try(:downcase).try(:split,'?').try(:first)
    extension
  end
end
