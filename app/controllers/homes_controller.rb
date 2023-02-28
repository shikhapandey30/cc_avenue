class HomesController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy ]
  include ApplicationHelper


  # GET /homes or /homes.json
  def index
    @homes = Home.all
    data = {
        order_id: 'order-id-1',
        currency: 'INR',
        amount: '100',
        redirect_url: 'http://www.bitterntec.com/',
        cancel_url: 'http://www.bitterntec.com/'

    }

    # enc_request=63957FB55DD6E7B968A7588763E08B240878046EF2F520C44BBC63FB9CCE726209A4734877F5904445591304ABB2F5E598B951E39EAFB9A24584B00590ADB077ADE5E8C444EAC5A250B1EA96F68D22E44EA2515401C2CD753DBA91BD0E7DFE7341BE1E7B7550&access_code=AVWP23KB52BT68PWTB&command=confirmOrder&request_type=JSON&response_type=JSON&version=1.1

    @encRequest = CcavenuePayment.encrypted_data(data)
    
    @ccavenue_request_url = CcavenuePayment.request_url
    @ccavenue_access_code = ENV.fetch('CCAVENUE_ACCESS_CODE').freeze
    @CCAVENUE_MERCHANT_ID = ENV.fetch('CCAVENUE_MERCHANT_ID').freeze

  end

  def payment_confirm
    # parameter to response is encrypted reponse we get from CCavenue
    @data = 'null'
    if params['encResponse'].present?
      @data = CcavenuePayment.decrypted_data(params['encResponse']) 
      # Return parameters:
      #   Auth Description: <String: Payment Failed/Success>
      #   Checksum Verification <Bool: True/False>
      #   Response Data: <HASH/Array: Order_id, amount etc>
    end
  end

  # GET /homes/1 or /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes or /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to home_url(@home), notice: "Home was successfully created." }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1 or /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to home_url(@home), notice: "Home was successfully updated." }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1 or /homes/1.json
  def destroy
    @home.destroy

    respond_to do |format|
      format.html { redirect_to homes_url, notice: "Home was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def home_params
      params.require(:home).permit(:title)
    end
end
