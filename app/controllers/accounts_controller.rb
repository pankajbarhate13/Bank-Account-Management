class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  layout "account", only: [:show, :deposite, :make_deposite, :withdraw, :make_withdraw, :transfer, :make_transfer, :statement]
  skip_before_filter :verify_authenticity_token, :only => [:index]
  include AccountsHelper

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deposite
    @deposite = Transaction.new
  end

  # For deposite money
  def make_deposite
    @dep = Transaction.create(account_id: params[:id], balance: params[:transaction][:deposite_amount], deposite_amount: params[:transaction][:deposite_amount])
    flash[:notice] = "Deposite successfully !"
    redirect_to account_url(params[:id])
  end

  def withdraw
    @withdraw = Transaction.new
  end

  # For withdraw money
  def make_withdraw
    if current_balance(params[:id]).to_i > params[:transaction][:withdraw_amount].to_i
      @wid = Transaction.create(account_id: params[:id], withdraw_amount: params[:transaction][:withdraw_amount])
      flash[:notice] = "Withdraw successfully !"
      redirect_to account_url(params[:id])
    else 
       flash[:error] = "Please enter withdraw amount less than your current_balance Rs: #{current_balance(params[:id])}/-"
      redirect_to request.referer
    end
  end

  def transfer
    @transfer = Transaction.new
  end

  # For transfer money
  def make_transfer
    if current_balance(params[:id]).to_i > params[:transaction][:transfer_amount].to_i
      @tran = Transaction.create(account_id: params[:id], transfer_amount: params[:transaction][:transfer_amount], reciever_account_id: params[:transaction][:reciever_account_id], sender_account_id: params[:id])
      flash[:notice] = "Transfer successfully !"
      redirect_to account_url(params[:id])
    else 
       flash[:error] = "Please enter transfer amount less than your current_balance Rs: #{current_balance(params[:id])}/-"
      redirect_to request.referer
    end
  end

  # To get Statements
  def statement
    @statements = Transaction.where("account_id = ?", params[:id]).order('created_at DESC').limit(10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      # params.fetch(:account, {})
      params.require(:account).permit(:first_name, :last_name, :address, :phone,:email)
    end
    
end
