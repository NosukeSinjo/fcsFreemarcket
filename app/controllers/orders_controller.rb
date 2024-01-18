class OrdersController < ApplicationController
    before_action :authenticate_user!
    def new
        @order = Order.new
    end

    def create
        @order = Order.new(order_params)
        @order.user = current_user
        @order.total_amount = @order.product.price
        @order.payment_method = "クレジットカード"
        @order.product.update(purchased_at: Time.current)

        if @order.save
            redirect_to @order, notice: '注文が正常に作成されました'
        else
            render :new
        end
    end

    def show
        @order = Order.find(params[:id])
    end
    

    private
    def order_params
        params.require(:order).permit(:product_id)
    end
end
