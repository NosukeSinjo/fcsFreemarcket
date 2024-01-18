class UsersessionsController < ApplicationController
    def new; end

    def create
        user = User.find_by(user_name: usersession_params[:user_name])
        user_sign_in(user) if user
        
        redirect_to user_path(user.id)
    end

    def destroy
        sign_out
        
        redirect_to root_path
    end

    private

    def usersession_params
        params.require(:usersession).permit(:user_name)
    end
end