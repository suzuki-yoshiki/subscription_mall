class StaticPagesController < ApplicationController
  before_action :map_object, only: :top

  def top
    @blogs = Blog.all
    @reviews = Review.all
    @questions = Question.all
    @medias = Medium.all.limit(5)
    @interviews = Interview.where.not(shop_name: nil)
    @owner_subscriptions = Subscription.includes(:owner).order("RANDOM()").limit(5)
    @subscription = Subscription.find_by(params[:id])
    @subscriptions = Subscription.where(recommend: true).order(created_at: :asc).limit(5)
    @megurumereviews = Megurumereview.all
    @owners = Owner.all.limit(5)
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RANDOM()").limit(6)
    else 
      Category.order("RANDOM()").limit(6)
    end
  end

  def top_owner
    @blogs = Blog.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RANDOM()").limit(6)
    else 
      Category.order("RANDOM()").limit(6)
    end
  end

  def megurume_line
    
  end

  def how_to_use
  end

  def discussion
  end

  def specified_commercial_transaction_law
  end

  def map_object
    if params[:map].present? && params[:map][:address].present?
      results = Geocoder.search(params[:map][:address])
      @latlng = results.first.geometry
      top = @latlng["location"]["lng"] + 0.2
      bottom = @latlng["location"]["lng"] - 0.2
      left = @latlng["location"]["lat"] + 0.2
      right = @latlng["location"]["lat"] - 0.2
      gon.subscriptions = Subscription.where(longitude: bottom..top).where(latitude: right..left)
    else
      gon.subscriptions = Subscription.all#where(longitude: 139.5..139.9).where(latitude: 35.4..35.8)
    end
  end

  private

end
