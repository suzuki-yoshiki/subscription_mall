# frozen_string_literal: true

class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :check_login, only: [:facebook, :twitter, :line]

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private

  def check_login
    if current_user || current_owner || current_admin
      flash[:danger] = "既にログインしています。別のユーザーとしてログインする場合は、一度ログアウトして下さい。"
      redirect_to root_url, notice: '既にログインしています。別のユーザーでログインする場合は、一度ログアウトして下さい。'
    end
  end
    
end
