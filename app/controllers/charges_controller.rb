class ChargesController < ApplicationController
  #after_action :cards_list, only: [:new]
  #after_action :cards_index, only: [:create]   
  
  def new
    if current_user.stripe_customer_id?
      @cards = Stripe::Customer.list_sources(
      current_user.stripe_customer_id,
      {
        limit: 5,
        object: 'card',
      }
      )
    end
  end

  def create    
    @amount = total_amount
    unless current_user.stripe_customer_id?

      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
        customer: customer.id, 
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'usd',
      })
       
      current_user.stripe_customer_id = customer.id
      current_user.update(:stripe_customer_id => customer.id) 
    else
      charge = Stripe::Charge.create({
        amount: @amount, 
        currency: 'usd',
        customer: current_user.stripe_customer_id,
      })
    end  
    @user_charge = UserCharge.new(:user_id => current_user.id, :stripe_charge_id => charge.id, :amount => charge.amount, :description => charge.description)
    @user_charge.save

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path   
  end
  
  def user_charge
    # @user_charge = UserCharge.new(:stripe_charge_id => charge.id, :amount => charge.amount, :description => charge.description)
    # @user_charge.save
  end

  def save_card
    card = Stripe::Customer.create_source(current_user.stripe_customer_id,
    {
      source: 'tok_mastercard',
    }
   )
  end  
end

