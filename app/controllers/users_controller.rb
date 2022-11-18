class UsersController < ApplicationController
  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def index
  end

  private
  def user_params
    # ここに、画像も許可する記述が必要
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
