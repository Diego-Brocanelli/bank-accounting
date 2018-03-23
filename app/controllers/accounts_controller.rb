class AccountsController < ApplicationController

  include Bank

  before_action :set_account, only: [:show, :update, :destroy]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  # concerning the action for deposit of money
  def deposit
    request_params = params.permit(:source_account_id, :destination_account_id, :amount)

    bank ||= Actions.new.deposit(
      request_params['source_account_id'], 
      request_params['destination_account_id'], 
      request_params['amount']
    )

    return render status: bank[0], json: bank[1]
  end

  # referring to the action to return the bank balance
  def balance
    request_params = params.permit(:account_id)

    balance ||= Actions.new.balance(request_params['account_id'])

    return render status: balance[0], json: balance[1]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.permit(:user_name, :number, :balance)
    end
end
