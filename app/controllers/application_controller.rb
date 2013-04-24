class ApplicationController < ActionController::Base
  protect_from_forgery

  def who_is email
    Customer.find_by_email(email)
  end

  def session_check
    if session[:cust_id].nil?
     redirect_to new_session_url
     flash[:notice] = "Please login to view your account!"
    else
      true
    end 
  end

end
