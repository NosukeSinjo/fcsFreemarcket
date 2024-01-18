class MerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
    end
    def new
        @merchant = Merchant.new
    end
    
    def create
        @merchant = Merchant.new(merchant_params)
        if @merchant.save!
            flash[:notice] = "登録が完了しました"
            redirect_to "/merchantlogin"
        else
            render new_merchant_path
        end
    end

    def show
        @merchant = Merchant.find(params[:id])
        @products = @merchant.products
        
    end

    private
    def merchant_params
        params.require(:merchant).permit(:merchant_name, :seller)
    end
end
