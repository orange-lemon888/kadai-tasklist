class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to '/login'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      @name = params[:user][:name]
      @email = params[:user][:email]
      @password = params[:user][:password]
      @password_confirmation = params[:user][:password_confirmation]
      render :new
    end
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end