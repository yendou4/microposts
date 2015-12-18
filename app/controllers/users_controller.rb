class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show #追加
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    if @user != current_user
      redirect_to root_path, alert: "不正なアクセスです！"
   end
  end 

  def update
    if @user != current_user
      redirect_to root_path, alert: "不正なアクセスです！"
    elsif @user.update_attributes(user_params)
      flash[:success]="Profile updatee"
      redirect_to @user
    else
     render'edit'
    end
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :area)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end