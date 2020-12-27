class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all

  end

  def show
    @ticket = Ticket.find(params[:id])

  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)

   if @ticket.save
       flash[:success] = "チケットを発券しました"
      redirect_to user_account_user_path(current_user)
   else
       flash[:danger] = "チケットが発見できませんせした"
       redirect_to root_path
   end
   current_user.update(issue_ticket_day: Date.today)
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(use_ticket_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:owner_name, :owner_email, :owner_phone_number, :owner_store_information, :owner_payee, :subscription_name, :subscription_fee, :issue_ticket_day, :user_id)
    end

    def use_ticket_params
      params.require(:ticket).permit(:use_ticket_day)
    end
end