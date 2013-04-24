class CreditsController < ApplicationController
 
  before_filter :credit_card_exists


  def index
    @credits = Credit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credits }
    end
  end

  # GET /credits/1
  # GET /credits/1.json
  def show
    @credit = Credit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit }
    end
  end

  # GET /credits/new
  # GET /credits/new.json
  def new
    @credit = Credit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit }
    end
  end

  # GET /credits/1/edit
  def edit
    @credit = Credit.find(params[:id])
  end

  # POST /credits
  # POST /credits.json
  def create
    @credit = Credit.new(params[:credit])

    current_credit = Credit.find_by_customer_id(session[:cust_id])
    
    authorise_amount @credit.amount

    if current_credit  
      current_credit.amount += @credit.amount
      @credit = current_credit
    else
      @credit.customer_id = session[:cust_id]
      @credit.save
    end




    respond_to do |format|
      if @credit.save
        format.html { redirect_to credits_url, notice: 'Credit was successfully created.' }
        format.json { render json: @credit, status: :created, location: @credit }
      else
        format.html { render action: "new" }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to @credit, notice: 'Credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.json
  def destroy
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to credits_url }
      format.json { head :no_content }
    end
  end

  def authorise_amount amount
    @id = current_customer.id
    @current_card = Creditcard.find_by_customer_id current_customer.id
    result = Braintree::Transaction.sale(
    :amount => amount,
    :credit_card => {
      :number => @current_card.card_number,
      :cvv => @current_card.cvv,
      :expiration_month => @current_card.expiration_month,
      :expiration_year => @current_card.expiration_year
    },
    :options => {
      :submit_for_settlement => true
    }
  )

  if result.success?
    "<h1>Success! Transaction ID: #{result.transaction.id}</h1>"
  else
    "<h1>Error: #{result.message}</h1>"
  end

  end

  private

   def credit_card_exists
    if !Creditcard.find_by_customer_id current_customer.id
      redirect_to new_creditcard_url
      flash[:notice] = "Add Credit Card"
    end
  end



end
