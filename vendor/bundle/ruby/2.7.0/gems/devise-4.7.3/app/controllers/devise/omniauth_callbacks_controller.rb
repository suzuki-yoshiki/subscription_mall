# frozen_string_literal: true

class Devise::OmniauthCallbacksController < DeviseController
  prepend_before_action { request.env["devise.skip_timeout"] = true }

  def passthru
    render status: 404, plain: "Not found. Authentication passthru."
  end

  def failure
    set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  # def line
  #   basic_action1 :line
  # end

  # def line_owner
  #   basic_action2 :line_owner
  # end

  private

  #   def basic_action1 # line ログイン用メソッドです
  #     @omniauth = request.env['omniauth.auth']
  #     if @omniauth.present?
  #       @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
  #       if @profile
  #         @profile.set_values(@omniauth)
  #         sign_in(:user, @profile)
  #       else
  #         @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
  #         @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
  #         @profile.set_values(@omniauth)
  #         sign_in(:user, @profile)
  #         # redirect_to edit_user_path(@profile.user.id) and return
  #       end
  #     end
  #     flash[:notice] = "ログインしました"
  #     redirect_to user_path(@profile)
  #   end

  #   def basic_action2 # line ログイン用メソッドです
  #     @omniauth = request.env['omniauth.auth']
  #     if @omniauth.present?
  #       @profile = Owner.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
  #       if @profile
  #         @profile.set_values(@omniauth)
  #         sign_in(:owner, @profile)
  #       else
  #         @profile = Owner.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
  #         @profile = current_owner || Owner.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
  #         @profile.set_values(@omniauth)
  #         sign_in(:owner, @profile)
  #         # redirect_to edit_owner_path(@profile.user.id) and return
  #       end
  #     end
  #     flash[:notice] = "ログインしました"
  #     redirect_to owner_path(@profile)
  #   end
  
  
    def failed_strategy
      request.respond_to?(:get_header) ? request.get_header("omniauth.error.strategy") : request.env["omniauth.error.strategy"]
    end

    def failure_message
      exception = request.respond_to?(:get_header) ? request.get_header("omniauth.error") : request.env["omniauth.error"]
      error   = exception.error_reason if exception.respond_to?(:error_reason)
      error ||= exception.error        if exception.respond_to?(:error)
      error ||= (request.respond_to?(:get_header) ? request.get_header("omniauth.error.type") : request.env["omniauth.error.type"]).to_s
      error.to_s.humanize if error
    end

    def after_omniauth_failure_path_for(scope)
      new_session_path(scope)
    end

    def translation_scope
      'devise.omniauth_callbacks'
    end
end
