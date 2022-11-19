class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログインしていない状態でtopページまたはaboutページ以外にアクセスする場合、ログイン画面にリダイレクトする
  before_action :authenticate_user!,except: [:top,:about]

  # protected
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_in,keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_up,keys: [:name,:email])
  end
end
