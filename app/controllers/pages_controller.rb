class PagesController < ApplicationController
  def index
    return unless user_signed_in?

    redirect_to users_path
  end
end
