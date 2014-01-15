class MediaProfilesController < ApplicationController
  # GET /media_profiles
  # GET /media_profiles.json
  def index
    @media_profiles = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media_profiles }
    end
  end

  # POST /filter_media_profiles
  def filter
    @media_type = params[:media_profile_select]
    if @media_type.to_sym == :all_media
      @media_profiles = MediaProfile.order('name asc')
    else
      @media_profiles = MediaProfile.filter_by_type(@media_type).order('name asc')
    end

    respond_to do |format|
      format.html { render :index }
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
    @media_profile.build_address
    @media_profile.address.city = City.where(name: 'Kuala Lumpur').first #default to KL

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
    if params[:media_profile][:address_attributes]
      params[:media_profile][:address_attributes].delete :city_attributes
    end
    @media_profile = MediaProfile.new(params[:media_profile])
    @media_profile.address.city = City.find(params[:city])
    #@media_profile.build_address

    respond_to do |format|
      if @media_profile.save
        format.html { redirect_to @media_profile, notice: t('media_profile_successfully_created') }
        format.json { render json: @media_profile, status: :created, location: @media_profile }
      else
        flash[:error] = @media_profile.errors.full_messages
        format.html { render action: "new" }
        format.json { render json: @media_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media_profiles/1
  # PUT /media_profiles/1.json
  def update
    if params[:media_profile][:address_attributes]
      params[:media_profile][:address_attributes].delete :city_attributes
    end
    @media_profile = MediaProfile.find(params[:id])
    @media_profile.address.city = City.find(params[:city])

    respond_to do |format|
      if @media_profile.update_attributes(params[:media_profile])
        format.html { redirect_to @media_profile, notice: t('media_profile_successfully_updated') }
        format.json { head :no_content }
      else
        flash[:error] = @media_profile.errors.full_messages
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
