class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    lat = params[:lat]
    lng = params[:lng]
    rayon = params[:rayon]
    nbr_shops = params[:nbr_shops]

    if lat.blank? || lng.blank? || (!(rayon.blank?) && !(nbr_shops.blank?))
      @shops = Shop.all
    else
      if !(rayon.blank?) && (rayon.to_i >= 0)
        @shops = Shop.within(rayon, origin: [lat, lng])
      else
        if !(nbr_shops.blank?) && (nbr_shops.to_i >= 0)
          @shops = Shop.by_distance(origin: [lat, lng]).limit(nbr_shops)
        else
          @shops = Shop.all
        end
      end
    end
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shop
    @shop = Shop.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def shop_params
    params.require(:shop).permit(:chain, :name, :address, :zip, :city, :phone, :country_code, :longitude, :latitude)
  end
end
