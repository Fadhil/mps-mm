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
    selected_media = params[:member_profile_select]
    flash[:notice]=selected_media
    redirect_to @event

  end
end
