class UsersController < ApplicationController
  include SessionsHelper
  before_action :correct_user, only: [:edit, :update]

  
  def show # 
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      flash[:success] ='Updated profile!'
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:location)
  end
  
  def set_message
    @user = User.find(params[:id])
  end  
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
  
end
