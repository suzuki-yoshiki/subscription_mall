class OwnersController < ApplicationController

  def index
    @owners = Owner.all
  end

  def interviews_index
    # owner = Owner.find(params[:id])
    # @interviews = owner.interviews
  end

  def show
    @owner = Owner.find(params[:id])
    @subscription = Subscription.find_by(params[:id])
    @subscriptions = Subscription.where.not(name: nil).size
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
