class SessionsController < ApplicationController

  before_filter :session_check, :only =>[:index]


  def create
    current_customer = who_is params[:email]
    
    if current_customer
      autenticate_password = current_customer.password_digest.eql? params[:password] 
      if autenticate_password 
       session[:cust_id] = current_customer.id
      end
    end

    if !current_customer || !autenticate_password
      call_exception
      redirect_to new_session_url
    end


  end

  def index

  end


  def call_exception
    flash[:notice] = 'Incorrect Email or Password'
  end

  def destroy
  end

  def new

    #no logic to be added. Simply renders the login page



  end

end
