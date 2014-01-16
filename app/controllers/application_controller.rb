class ApplicationController < ActionController::Base
  layout 'landing', only: [:welcome]

  before_filter :authenticate_user!
  #before_filter :configure_permitted_parameters, if: :devise_controller?


  protect_from_forgery
  def city_dropdown
    @cities = City.where(state_name: params[:state])
    respond_to do |format|
      format.html { render layout: false }
    end
  end


  def welcome

  end


end
