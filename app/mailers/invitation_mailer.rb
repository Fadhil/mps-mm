class InvitationMailer < ActionMailer::Base
  default from: "fadhil.luqman@gmail.com"

  def send_invites(media_profile, event)
    "in invitation mailer\n"
    @media_profile = media_profile
    @event = event
    mail(to: @media_profile.email, subject: "Anda dijemput ke acara #{@event.name}")
  end
end
