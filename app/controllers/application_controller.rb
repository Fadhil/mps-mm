class ApplicationController < ActionController::Base
  protect_from_forgery
  def city_dropdown
    @cities = City.where(state_name: params[:state])
    respond_to do |format|
      format.html { render layout: false }
    end
  end
end
