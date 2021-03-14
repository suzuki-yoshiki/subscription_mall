require "action_pack"
require "active_support/rails"
require "active_support/i18n"

module AbstractController
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Caching
  autoload :Callbacks
  autoload :Collector
  autoload :DoubleRenderError, "abstract_controller/rendering"
  autoload :Helpers
  autoload :Logger
  autoload :Rendering
  autoload :Translation
  autoload :AssetPaths
  autoload :UrlFor

  def self.eager_load!
    super
    AbstractController::Caching.eager_load!
  end
  
  def line
    basic_action1 :line
  end

  def line_owner
    basic_action2 :line_owner
  end

  private

    def basic_action1 # line ログイン用メソッドです
      @omniauth = request.env['omniauth.auth']
      if @omniauth.present?
        @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
        if @profile
          @profile.set_values(@omniauth)
          sign_in(:user, @profile)
        else
          @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
          @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
          @profile.set_values(@omniauth)
          sign_in(:user, @profile)
          # redirect_to edit_user_path(@profile.user.id) and return
        end
      end
      flash[:notice] = "ログインしました"
      redirect_to user_path(@profile)
    end

    def basic_action2 # line ログイン用メソッドです
      @omniauth = request.env['omniauth.auth']
      if @omniauth.present?
        @profile = Owner.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
        if @profile
          @profile.set_values(@omniauth)
          sign_in(:owner, @profile)
        else
          @profile = Owner.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
          @profile = current_owner || Owner.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
          @profile.set_values(@omniauth)
          sign_in(:owner, @profile)
          # redirect_to edit_owner_path(@profile.user.id) and return
        end
      end
      flash[:notice] = "ログインしました"
      redirect_to owner_path(@profile)
    end
  
end
