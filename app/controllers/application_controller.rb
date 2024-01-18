class ApplicationController < ActionController::Base
        helper_method :current_user, :current_merchant, :merchant_logged_in?, :user_logged_in?

    private
    def authenticate_user!
        redirect_to "/userlogin" unless current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def current_merchant
        @current_merchant ||= Merchant.find_by(id: session[:merchant_id]) if session[:merchant_id]
    end

    def merchant_sign_in(merchant)
        session[:merchant_id] = merchant.id
    end

    def user_sign_in(user)
        session[:user_id] = user.id
    end
    
    def merchant_logged_in?
        !current_merchant.nil?
    end

    def user_logged_in?
        !current_user.nil?
    end

    def sign_out
        session[:user_id] = nil
        session[:merchant_id] = nil
    end

    def generate_receipt(order)
        pdf = Prawn::Document.new
        font_path = Rails.root.join('app', 'assets', 'fonts', 'NotoSerifJP-Black.otf')

        # フォントの読み込み
        pdf.font_families["NotoSerifJP"] = {
            normal: { file: font_path, font: "NotoSerifJP" }
        }

        pdf.font("NotoSerifJP") do
            pdf.text "領収書", size: 20
            pdf.text "発行日時: #{order.created_at}"
            pdf.text "注文番号: #{order.id}"
            pdf.text "商品名: #{order.product.title}"
            pdf.text "金額: #{order.total_amount} STC"
            pdf.text "購入者情報: #{order.user.user_name}"
            pdf.text "支払い方法: #{order.payment_method}"
            pdf.text "企業情報: #{order.product.merchant.merchant_name}"
            pdf.text "備考欄: この領収書は有効期限内にご利用ください。"
          end
      
        pdf_path = Rails.root.join('tmp', 'receipts', "receipt_#{order.id}.pdf")
        pdf.render_file(pdf_path)
      
        pdf_path
    end

end
