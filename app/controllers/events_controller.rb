class EventsController < ApplicationController
  # GET /events
  # GET /events.json
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
      InvitationMailer.delay(:run_at => 1.minutes.from_now ).send_invites(m, @event)
      @event.add_participant(m)
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
end
