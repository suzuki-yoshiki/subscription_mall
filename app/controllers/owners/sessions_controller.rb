# frozen_string_literal: true

class Owners::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_login, only: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    login_owner = Owner.find_by(email: params[:owner][:email])
    login_owner.update!(deleted_at: nil) if login_owner.present? && login_owner.deleted_at.present?
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def check_login
    if current_user || current_owner || current_admin
      flash[:danger] = "既にログインしています。別のユーザーとしてログインする場合は、一度ログアウトして下さい。"
      redirect_to root_url, notice: '既にログインしています。別のユーザーでログインする場合は、一度ログアウトして下さい。'
    end
  end

end
