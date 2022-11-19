class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログインしていない状態でtopページまたはaboutページ以外にアクセスする場合、ログイン画面にリダイレクトする
  before_action :authenticate_user!,except: [:top,:about]

  def after_sign_in_path_for(resource)
      user_path(resource)
  end

  def after_sign_up_path_for(resource)
      user_path(resource)
  end

  protected
  # private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_in,keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_up,keys: [:name,:email])
  end
end
