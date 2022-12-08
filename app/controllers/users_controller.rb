class UsersController < ApplicationController
  before_action :set_params, only: [:show]

  def index
    logger.info(LogFormatter.basic("aiueo"))
    render json: User.all
  end

  def show
    logger.info(LogFormatter.athena({
        "user_id": @user.id,
        "data": 'hoge'
      },
                        "user_show"
    ))
    render json: @user
  end

  private
  def set_params
    begin
      @user = User.find(params[:id])
    rescue => e
      logger.error(LogFormatter.exception(e, 'DATA_ACCESS_ERROR'))
      throw e
    end
  end

  def user_params
    params.require(:user)
          .permit(:name)
  end
end
