  class UsersController < ApplicationController
    layout 'standard'

    def index
      @users = User.where.not(id: current_user.id)
      @user = User.find_by(id: current_user.id)
    end

    def show
      @user = User.find_by(id: params[:id])
    end
  end
