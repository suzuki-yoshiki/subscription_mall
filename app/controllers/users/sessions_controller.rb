# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_login, only: [:new]


  # GET /resource/sign_in
  # def new
    # super
  # end

  # POST /resource/sign_in
  def create
    login_user = User.find_by(email: params[:user][:email])
    login_user.update!(deleted_at: nil) if login_user.present? && login_user.deleted_at.present?
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

 protected 

  def check_login
    if current_user || current_owner || current_admin
      flash[:danger] = "既にログインしています。別のユーザーとしてログインする場合は、一度ログアウトして下さい。"
      redirect_to root_url, notice: '既にログインしています。別のユーザーでログインする場合は、一度ログアウトして下さい。'
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
