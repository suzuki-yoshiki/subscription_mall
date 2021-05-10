class CategoriesController < ApplicationController
  before_action :set_category, only: [:like_lunch]
  # before_action :set_subscription, only: [:show]
  before_action :categories_lock, only: %i(new edit)
  before_action :current_user_email_present?, only: %i(trial_shop)


  def index
    @category_all = Category.all
  end

  def like_lunch
    @subscriptions = @category.subscriptions.where(admin_check: "加盟店承認済み")
    @private_stores = @category.private_stores.where(admin_check_private: "個人店承認済み")
    @subscriptions = @category.subscriptions
    @private_stores = @category.private_stores
    if current_user.present?
      current_user.update!(select_trial: false)  if current_user.plan_canceled || (!current_user.trial_stripe_success && current_user.select_trial)
    end
  end

  def trial_shop
    @subscriptions = Subscription.where(trial: true)
    @private_stores = PrivateStore.where(trial: true)
    if current_user.present?
      current_user.update!(select_trial: true) if current_user.price.blank?
    end
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params[:category_id].present?
      redirect_to like_lunch_category_url(params[:category_id])
    else
      redirect_to categories_url
    end
  end


  def shop_list
    @subscriptions = Subscription.where(recommend: true).order(created_at: :asc).paginate(page: params[:page], per_page: 10)
    @private_stores = PrivateStore.all.order(created_at: :asc).paginate(page: params[:page], per_page: 10)
  end

  def recommend
    @subscriptions = Subscription.where(recommend: true).order(created_at: :asc).paginate(page: params[:page], per_page: 10)
    @private_stores = PrivateStore.where(recommend: true).where(admin_private_check: "個人店舗データ反映済み").order(created_at: :asc).paginate(page: params[:page], per_page: 10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :image_category, :user_id, :owner_id)
    end

    def categories_lock
      unless current_admin.present?
        redirect_to root_url, notice: '権限がありません'
      end
    end
end
