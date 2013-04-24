class ApplicationController < ActionController::Base
  protect_from_forgery

  def who_is email
    Customer.find_by_email(email)
  end

  def session_check
    if session[:cust_id].nil?
     redirect_to login_url
     flash[:notice] = "Please login to view your account!"
    else
      true
    end 
  end

  def current_customer
    Customer.find_by_id(session[:cust_id])
  end

end
