class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @reviews = Review.all
    @questions = Question.all
    @megurumereviews = Megurumereview.all
    if params[:map].present? && params[:map][:address].present?
      results = Geocoder.search(params[:map][:address])
      @latlng = results.first.geometry
    end
    @owners = Owner.all
    gon.subscriptions = Subscription.all
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
    results = Geocoder.search(params[:address])
    @latlng = results.first
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RANDOM()").limit(6)
    else 
      Category.order("RANDOM()").limit(6)
    end
  end

  def how_to_use
  end

  def discussion
  end

  private

end
