class ProductsController < ApplicationController
    
    def index
        @receipt = Receipt.all
    end

    def new
        @receipt = current_merchant.receipts.new
    end

    def create
        @product = current_merchant.products.new(product_params)
        if @product.save!
            flash[:success] = "商品を追加しました。"
            redirect_to merchant_path(current_merchant)
        end
    end

    def destroy
        product = Product.find(params[:id])
        product.destroy
        redirect_to products_path
    end

    def show
        @product = Product.find(params[:id])
    end

    def get_image
        product = Product.find(params[:id])
        send_data product.image.read, disposition: :inline, type: 'png'
    end

    private
    def product_params
        params.require(:product).permit(:merchant_id, :title, :price, :description, :image)
    end
end
