class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents

    @amount = 500

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

    unless current_user.stripe_customer_id?
      current_user.stripe_customer_id = customer.id
      current_user.update(:stripe_customer_id => customer.id) 
    end   
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path   
  end
  
end
