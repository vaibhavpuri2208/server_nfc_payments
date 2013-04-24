class CreditcardsController < ApplicationController

  before_filter :session_check

  def index
    @creditcards = Creditcard.where(:customer_id=>session[:cust_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creditcards }
    end
  end

  def show
    @creditcard = Creditcard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @creditcard }
    end
  end

  def new
    @creditcard = Creditcard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creditcard }
    end
  end

  def edit
    @creditcard = Creditcard.find(params[:id])
  end

  def create
    @creditcard = Creditcard.new(params[:creditcard])
    @creditcard.customer_id = session[:cust_id]
    respond_to do |format|
      if @creditcard.save
        format.html { redirect_to credits_url, notice: 'Creditcard was successfully created.' }
        format.json { render json: @creditcard, status: :created, location: @creditcard }
      else
        format.html { render action: "new" }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @creditcard = Creditcard.find(params[:id])

    respond_to do |format|
      if @creditcard.update_attributes(params[:creditcard])
        format.html { redirect_to @creditcard, notice: 'Creditcard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @creditcard = Creditcard.find(params[:id])
    @creditcard.destroy

    respond_to do |format|
      format.html { redirect_to creditcards_url }
      format.json { head :no_content }
    end
  end
end
