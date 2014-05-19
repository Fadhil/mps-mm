class EventsController < ApplicationController
  # GET /events
  # GET /events.json

  skip_before_filter :authenticate_user!, only: [ :open_email ]
  layout 'empty', only: [:terima_kasih, :coming]
  def index
    @events = Event.order('date desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def filter
    @events = []
    unless params.empty?
      @events = Event.where('name like ?',"%#{params[:search]}%")
    end

    respond_to do |format|
      format.html {render :index}
      format.json {render json: @events}
    end

  end

  # GET /events/1
  # GET /events/1.json
  def show
    @selected_media_ids = params[:selected_media_ids]
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.generate_attendance_list
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: t('event_successfully_created') }
        format.json { render json: @event, status: :created, location: @event }
      else
        flash[:error] = @event.errors.full_messages
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    @event.generate_attendance_list
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: t('event_successfully_updated') }
        format.json { head :no_content }
      else
        flash[:error] = @event.errors.full_messages
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def send_invites
    @event = Event.find(params[:id])
    media_type = params[:media_profile_select]
    if params[:button] == :send.to_s
      if params[:selected_media_ids]
        selected_media_ids = params[:selected_media_ids]
        selected_media = MediaProfile.where('id in (?)',selected_media_ids)
      else
        selected_media = MediaProfile.filter_by_type(media_type)
      end
    elsif params[:button] == :send_ids.to_s
      selected_media = MediaProfile.first
    end

    flash[:notice]="Berjaya menghantar jemputan kepada #{selected_media.count} orang."
    selected_media.each do |m|
      #InvitationMailer.delay(:run_at => 1.minutes.from_now ).send_invites(m, @event)
      attendee = @event.add_participant(m)
      InvitationMailer.send_invites(m,@event, attendee).deliver
      
    end
    redirect_to @event

  end

  def edit_recipients
    @event = Event.find(params[:id])
    media_type = params[:media_profile_select]
    @selected_media = MediaProfile.filter_by_type(media_type)
    #@selected_media = params[:selected_media]
  end

  def update_attendance
    @attendance_list = Event.find(params[:id]).attendance_list
    present_radio = params[:present_radio]
    if present_radio
      present_radio.each do |key, value|
        attendee = Attendee.find(key)
        attendee.attendance_status = value
        attendee.email_read = true
        attendee.save
      end
      
    end
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
    end
    # media_profile = MediaProfile.find(params[:media_profile_id]) rescue nil 
    # attendance = Attendee.find(params[:attendee_id]) rescue nil
    # event = Event.find(params[:event_id]) rescue nil
    # attended = params[:attended]
    # attendance.attended = attended
    # attendance.attendance_status = params[:attendance_status]


    # if attendance.save
    #   respond_to do |format|
    #     format.html do
    #       @event = event
    #       flash[:notice] = t('event_successfully_updated')
    #       redirect_to request.referrer
    #       #render action: '../pages/upcoming_courses_show'
    #     end
    #   end
    # end

  end

  def update_rsvp
    attendee = Attendee.find(params[:attendee_id])
    rsvp_response = params[:rsvp_response]
    already_responded = true
    if attendee.rsvp.nil?
      attendee.rsvp = rsvp_response
      attendee.email_read = true
      already_responded = false
    end

    respond_to do |format|
      if already_responded
        format.html { redirect_to already_responded_event_path }
      else
        if attendee.save 
          #flash[:notice] = "Attendee: #{params[:attendee_id]}, RSVP: #{params[:rsvp_response]}"
          format.html { redirect_to terima_kasih_event_path(rsvp_response: rsvp_response) }
        end
      end
    end
  end

  def terima_kasih
    rsvp_response = params[:rsvp_response]
    coming_message = "Terima Kasih kerana sudi menghadiri acara kami. "
    not_coming_message = "Terima kasih kerana mengambil masa untuk menjawab RSVP kami. Semoga boleh jumpa lagi di acara lain."
    @message = (rsvp_response.to_i == 1) ? coming_message : not_coming_message
  end

  def already_responded

  end
  def track_open
    @attendee = Attendee.find(params[:attendee_id])
    @attendee.email_read = true
    @attendee.save
    send_file "#{Rails.root}/public/assets/images/trackimgwhite.png", :type => 'image/png', :disposition => 'inline' 
    #send_data open(url, "rb") { |f| f.read }
  end

  def add_walkins
    @attendance_list = Event.find(params[:id]).attendance_list
    @attendance_list.update_attributes(params[:attendance_list])
    @attendance_list.save
    present_radio = params[:present_radio]
    if present_radio
      present_radio.each do |key, value|

      end
      Rails.logger.info "\n\n\n\n\npresent radio: #{present_radio}\n\n\n\n\n\n"
    end
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
    end
  end

  def coming
    @event = Event.find(params[:id])
    @attendee = Attendee.find(params[:attendee_id])
  end

  def open_email
    Rails.logger.info "in here\n\n"
    unless params[:mandrill_events].nil?
      Rails.logger.info "params are: #{params[:mandrill_events]}\n\n"
      @track = JSON.parse(params[:mandrill_events])
      @track.each do |t|
        event_name = t['msg']['subject'].gsub('Anda dijemput ke acara','').strip
        email = t['msg']['email'].strip

        event = Event.where(name: event_name).first
        Rails.logger.info "email: #{email} , event: #{event}\n"
        if event
          attendee = event.attendance_list.attendees.where(email: email).first
          if attendee
            attendee.email_read = true
            attendee.save
          end
        end
      end
      respond_to do |format|
        format.html
        format.json {}
      end
    end
  end
end
