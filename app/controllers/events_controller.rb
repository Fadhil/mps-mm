class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  layout 'empty', only: [:terima_kasih]
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
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
    selected_media_type = params[:media_profile_select]
    if selected_media_type == 'all_media'
      selected_media = MediaProfile.all
    else
      selected_media = MediaProfile.where(media_type: selected_media_type)
    end
    flash[:notice]="Berjaya menghantar jemputan kepada #{selected_media.count} orang."
    selected_media.each do |m|
      #InvitationMailer.delay(:run_at => 1.minutes.from_now ).send_invites(m, @event)
      attendee = @event.add_participant(m)
      InvitationMailer.send_invites(m,@event, attendee).deliver
      
    end
    redirect_to @event

  end

  def update_attendance
    media_profile = MediaProfile.find(params[:media_profile_id]) rescue nil 
    attendance = Attendee.find(params[:attendee_id]) rescue nil
    event = Event.find(params[:event_id]) rescue nil
    attended = params[:attended]
    attendance.attended = attended
    attendance.attendance_status = params[:attendance_status]


    if attendance.save
      respond_to do |format|
        format.html do
          @event = event
          flash[:notice] = t('event_successfully_updated')
          redirect_to request.referrer
          #render action: '../pages/upcoming_courses_show'
        end
      end
    end

  end

  def update_rsvp
    attendee = Attendee.find(params[:attendee_id])
    rsvp_response = params[:rsvp_response]
    attendee.rsvp = rsvp_response

    respond_to do |format|
      if attendee.save 
        #flash[:notice] = "Attendee: #{params[:attendee_id]}, RSVP: #{params[:rsvp_response]}"
        format.html { redirect_to terima_kasih_event_path(rsvp_response: rsvp_response) }
      end
    end
  end

  def terima_kasih
    rsvp_response = params[:rsvp_response]
    coming_message = "Terima Kasih kerana sudi menghadiri acara kami. "
    not_coming_message = "Terima kasih kerana mengambil masa untuk menjawab RSVP kami. Semoga boleh jumpa lagi di acara lain."
    @message = (rsvp_response.to_i == 1) ? coming_message : not_coming_message
  end

  def track_open
    url = 'http://farm1.staticflickr.com/54/120671629_8b7514a186_o.jpg'
    the_host = request.port.blank? ? request.host : "#{request.host}:#{request.port}"
    local_url = request.protocol + the_host + '/assets/images/rails.png'
    image = open(local_url).read
    logger.info local_url
    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'
    render text: image
  end

  def add_walkins
    @attendance_list = Event.find(params[:id]).attendance_list
    @attendance_list.update_attributes(params[:attendance_list])
    @attendance_list.save
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
    end
  end
end
