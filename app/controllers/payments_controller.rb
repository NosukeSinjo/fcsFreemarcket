class PaymentsController < ApplicationController
    before_action :authenticate_user!

    def new
        # 支払い情報を入力するフォームを表示するアクション
        @payment = Payment.new
        # 支払い情報を収集するための新しいPaymentモデルを作成
    end

    def create
        # 支払いを行うアクション
        @payment = Payment.new(payment_params)
        @payment.user = current_user

        if @payment.save
        # 支払いが成功した場合の処理
        redirect_to @payment, notice: '支払いが正常に行われました。'
        else
        # 支払いが失敗した場合の処理
        render :new
        end
    end

    def show
        # 支払いの詳細を表示するアクション
        @payment = Payment.find(params[:id])
    end

    private

    def payment_params
        params.require(:payment).permit(:order_id, :amount, :payment_method)
    end
end
