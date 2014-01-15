class ApplicationController < ActionController::Base
  layout 'empty', only: [:welcome]
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
