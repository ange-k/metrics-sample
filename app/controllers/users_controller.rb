class UsersController < ApplicationController
  before_action :set_params, only: [:show]

  def index

    render json: User.all
  end

  def show

  end

  private
  def set_params
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:name)
  end
end
