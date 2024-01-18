class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show]
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_name: params[:user][:user_name])
        if @user.save!
            flash[:notice] = "登録が完了しました"
            redirect_to "/userlogin"
        else
            render new_user_path
        end
    end

    def show
        @user = User.find(params[:id])
        redirect_to "/userlogin" unless current_user == @user
        @orders = @user.orders
    end

    def show_receipt
        @user = current_user
        @order = @user.orders.last
        @receipt_path = generate_receipt(@order)
      
        send_file @receipt_path, filename: "receipt.pdf", type: "application/pdf", disposition: "inline"
      end
end
