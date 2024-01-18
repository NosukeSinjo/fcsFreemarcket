class MerchantsessionsController < ApplicationController
    def new; end

    def create
        merchant = Merchant.find_by(merchant_name: merchantsession_params[:merchant_name])
        merchant_sign_in(merchant) if merchant
        
        redirect_to merchant_path(merchant.id)
    end

    def destroy
        sign_out
        
        redirect_to root_path
    end

    private

    def merchantsession_params
        params.require(:merchantsession).permit(:merchant_name)
    end
end