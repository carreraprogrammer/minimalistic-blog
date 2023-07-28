  class UsersController < ApplicationController
    layout 'standard'

    def index
      @user = current_user
    end

    def show
      @user = User.find_by(id: params[:id])
    end
  end
