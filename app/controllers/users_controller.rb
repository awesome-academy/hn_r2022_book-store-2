class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = t "success"
      redirect_to root_path
    else
      flash.now[:danger] = t "sign_fail"
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit User::PROPERTIES
  end
end
