class HomeController < ApplicationController
  def show
    redirect_to records_path if user_signed_in?
  end
end
