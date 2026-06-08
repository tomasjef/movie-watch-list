class PagesController < ApplicationController
  def home
    redirect_to lists_path if user_signed_in?
  end
end
