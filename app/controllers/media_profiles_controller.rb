class MediaProfilesController < ApplicationController
  # GET /media_profiles
  # GET /media_profiles.json
  def index
    @media_profiles = MediaProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media_profiles }
    end
  end

  # GET /media_profiles/1
  # GET /media_profiles/1.json
  def show
    @media_profile = MediaProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @media_profile }
    end
  end

  # GET /media_profiles/new
  # GET /media_profiles/new.json
  def new
    @media_profile = MediaProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @media_profile }
    end
  end

  # GET /media_profiles/1/edit
  def edit
    @media_profile = MediaProfile.find(params[:id])
  end

  # POST /media_profiles
  # POST /media_profiles.json
  def create
    @media_profile = MediaProfile.new(params[:media_profile])

    respond_to do |format|
      if @media_profile.save
        format.html { redirect_to @media_profile, notice: 'Media profile was successfully created.' }
        format.json { render json: @media_profile, status: :created, location: @media_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @media_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media_profiles/1
  # PUT /media_profiles/1.json
  def update
    @media_profile = MediaProfile.find(params[:id])

    respond_to do |format|
      if @media_profile.update_attributes(params[:media_profile])
        format.html { redirect_to @media_profile, notice: 'Media profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @media_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_profiles/1
  # DELETE /media_profiles/1.json
  def destroy
    @media_profile = MediaProfile.find(params[:id])
    @media_profile.destroy

    respond_to do |format|
      format.html { redirect_to media_profiles_url }
      format.json { head :no_content }
    end
  end
end
