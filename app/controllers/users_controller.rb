class UsersController < ApplicationController
  # 他の人が自分のユーザ情報をいじれないようにする
  before_action :is_matching_login_user, only: [:edit,:update]

  def show
  end

  def edit
    # 他の人が自分のユーザ情報をいじれないようにする
    # is_matching_login_user

    @user = User.find(params[:id])
  end

  def update
    # 他の人が自分のユーザ情報をいじれないようにする
    # is_matching_login_user

    @user = User.find(params[:id])
    # バリデーションに抵触した場合、そのページに留まります
    if @user.update(user_params)
      # フラッシュメッセージを設定
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
  end

  private

  def user_params
    # ここに、画像も許可する記述が必要
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  # 他の人が自分のユーザ情報をいじれないようにする
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user.id)
    end
  end

end
