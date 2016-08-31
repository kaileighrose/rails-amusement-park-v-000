require 'pry'
class UsersController < ApplicationController

  def home
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    if session[:user_id]
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  def signin
    @user = User.new
  end

  def login
    @user = User.find_by(name: params[:user][:name])
    if @user.authenticate(params[:user][:password]) 
      session[:user_id] = @user.id
    end
    if session[:user_id] == nil
      redirect_to '/'
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def show
    if session[:user_id] != nil && session[:user_id] == params[:id].to_i
      @user = User.find(params[:id])
    else
      redirect_to '/'
    end
  end

  def index
    @users = User.all 
  end

  private

  def user_params
    params.require(:user).permit(:name, :tickets, :happiness, :height, :nausea, :password, :admin)
  end
end
