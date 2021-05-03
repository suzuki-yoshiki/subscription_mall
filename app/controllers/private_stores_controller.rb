class PrivateStoresController < ApplicationController
  before_action :set_private_store, only: [:update, :show, :edit, :update, :destroy, :edit_recommend, :update_recommend, :takeout]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :owner_private_stores, :edit_recommend, :update_recommend, :private_store_confirm, :private_store_judging, :takeout]
  # before_action :set_user, only: [:favorite, :edit_favorite, :update_favorite]
  before_action :create, only: [:private_store_judging]
  before_action :set_category, only: [:edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :payment_check, only: %i(show)
  before_action :sub_current_owner, only: %i(edit index)
  # before_action :set_owner_private_store, only: %i()

  # GET /private_stores
  # GET /private_stores.json
  ##各経営者のサブスク一覧
  def index
    @private_stores = @owner.private_stores
    @private_stores_count = @owner.private_stores.count
  end

  def private_all_shop
    @private_stores = PrivateStore.where(admin_last_check: "個人承認審査済み")
    @private_stores_count = PrivateStore.where(admin_last_check: "個人承認審査済み").count
    @private_stores = PrivateStore.all
    if current_user.present?
      current_user.update!(select_trial: false)  if current_user.plan_canceled || (!current_user.trial_stripe_success && current_user.select_trial)
    end
  end

  def owner_private_stores
    @private_stores = @owner.private_stores
  end

  def show
    gon.private_stores = @private_store
    @sub_images = @private_store.images
    @reviews = @private_store.reviews.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    @ticket = Ticket.includes(:user)
  end

  def like_lunch
    @private_store = PrivateStore.find(params[:private_store_id])
  end

  def list
    @private_stores = PrivateStore.includes(:owner)
  end

  def shop_case
    @private_stores = PrivateStore.includes(:owner)
  end

  def edit_recommend#おすすめ追加
  end

  def update_recommend#おすすめ追加
    if @private_store.update(recommend_params)
      if @private_store.recommend == true
        @private_store.recommend = true
      flash[:success] = "#{@owner.name}様サブスクをおすすめ店舗に加えました。"
      elsif @private_store.recommend == false
        @private_store.recommend = false
      end
      redirect_to recommend_categories_url
    end
  end


  # GET /private_stores/1
  # GET /private_stores/1.json

  def plan_description
  end

  # GET /private_stores/new
  def new
    @private_store = PrivateStore.new
    # @private_store.images.build
    @categories = Category.all
  end

  #審査申込確認画面
  def private_store_confirm
    if @private_store = PrivateStore.new(private_store_params)
      render :private_store_confirm
    else
     render :new
    end
  end

  #審査申込完了画面
  def private_store_judging
  end


  # POST /private_stores
  # POST /private_stores.json
  def create
    @categories = Category.all
    @private_store = PrivateStore.new(private_store_params)
    respond_to do |format|
      if @private_store.save
        @private_store.update(ordinal: PrivateStore.count)
        PrivateStoreMailer.with(private_store: @private_store, new: "true").notification_email.deliver_now
        format.html { render :private_store_judging, notice: '個人店サブスクショップの審査申請しました' }
        format.json { render :show, status: :created, location: @private_store }
      else
        format.html { render :new }
        format.json { render json: @private_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /private_stores/1/edit
  def edit
    @categories = Category.all
    @private_store.images.build
    @private_store_instablog = PrivateStoreInstablog.new
  end

  # PATCH/PUT /private_stores/1
  # PATCH/PUT /private_stores/1.json
  def update
    @images = Image.where.not(id: nil)
    @categories = Category.all
    respond_to do |format|
      if @private_store.update(private_store_params)
        PrivateStoreMailer.with(private_store: @private_store, new: "false").notification_email.deliver_now
        format.html { redirect_to owner_private_stores_url(owner_id: @owner.id), notice: 'サブスクショップを更新しました' }
        format.json { render :show, status: :ok, location: @private_store }
      else
        format.html { render :edit }
        format.json { render json: @private_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_stores/1
  # DELETE /private_stores/1.json
  def destroy
    targets = PrivateStore.where(ordinal: (@private_store.ordinal + 1)..Float::INFINITY)
    targets.each do |target|
      target.update(ordinal: target.ordinal - 1)
    end
    @private_store.destroy
    respond_to do |format|
      format.html { redirect_to owner_private_stores_url(owner_id: @owner.id), notice: 'サブスクショップを削除しました' }
      format.json { head :no_content }
    end
  end

  def show_sample
  end

  def company_profile
  end

  def takeout
    if @private_store.takeout?
      ticket = Ticket.find_by(user_id: current_user.id)
      if ticket.present?
        ticket.update!(
          owner_name: @owner.name,
          owner_email: @owner.email,
          owner_phone_number: @owner.phone_number,
          owner_store_information: @owner.store_information,
          price: @private_store.price,
          subscription_name: @private_store.name,
          category_id: @private_store.category_id,
          issue_ticket_day: Date.today,
          user_id: current_user.id,
        ) 
      else
        ticket = Ticket.create!(
          owner_name: @owner.name,
          owner_email: @owner.email,
          owner_phone_number: @owner.phone_number,
          owner_store_information: @owner.store_information,
          price: @private_store.price,
          subscription_name: @private_store.name,
          category_id: @private_store.category_id,
          issue_ticket_day: Date.today,
          user_id: current_user.id,
        ) 
      end
      redirect_to user_ticket_url(ticket, user_id: current_user.id)
      PrivateStoreMailer.with(id: current_user.id, private_store_id: @private_store.id).takeout_email.deliver_now
    else
      redirect_to like_lunch_category_url(@private_store.category_id)
    end
  end

  def strip
      # サブスク登録
      Stripe::Checkout::Session.create(
        success_url: private_store_success_url,
        cancel_url: private_store_cancel_url,
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          price: params[:session],
          quantity: 1},
        ],
        mode: 'subscription',
      )
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_private_store
        @private_store = PrivateStore.find(params[:id])
      end

      def set_owner
        @owner = Owner.find(params[:owner_id])
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_category
        @category = Category.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def private_store_params
        params.require(:private_store).permit(:name,
                                              :title,
                                              :address,
                                              :shop_introduction,
                                              :detail,
                                              :qr_image,
                                              :image_private_store,
                                              :sub_image,
                                              :sub_image2,
                                              :sub_image3,
                                              :sub_image4,
                                              :sub_image5,
                                              :sub_image6,
                                              :sub_image7,
                                              :sub_image8,
                                              :sub_image9,
                                              :sub_image10,
                                              :sub_image11,
                                              :sub_image12,
                                              :admin_private_check,
                                              :private_store_detail,
                                              :price,
                                              :situation,
                                              :site,
                                              :phone_number,
                                              :email,
                                              :category_id,
                                              :owner_id,
                                              :product_id,
                                              :trial,
                                              :takeout,
                                              :preparation_time,
                                              :food_loss,
                                              :delivery,
                                              # { :images_attributes=> [:private_store_id, :private_store_image]},
                                              #{ :category_ids=> [] }
                                            )
      end

      def recommend_params
        params.require(:private_store).permit(:recommend, :owner_id)
      end

      def favorite_params
        params.require(:private_store).permit(:favorite, :user_id)
      end

      def map_params
        params.require(:map).permit(:address, :distance, :time)
      end

      # 現在ログインしている経営者を許可します。
      def sub_current_owner
        @owner = Owner.find(params[:owner_id]) if @owner.blank?
        unless current_owner?(@owner) or current_admin.present?
          redirect_to owner_private_stores_url(current_owner), notice: '他の経営者様のページへ移動できません。'
        end
      end

      # 現在ログインしている経営者を許可します。
      def set_owner_private_store
        @owner = Owner.find(params[:owner_id])
        unless @owner.private_stores.find_by(id: params[:id])
          flash[:danger] = "権限がありません。"
          redirect_to owner_private_stores_url @owner, notice: '権限がありません！'
        end
      end

end
