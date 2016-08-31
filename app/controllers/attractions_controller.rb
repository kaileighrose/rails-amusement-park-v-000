class AttractionsController < ApplicationController

  def new
    @attraction = Attraction.new
  end

  def create
    if current_user.admin == true
      attraction = Attraction.create(attraction_params)
      redirect_to attraction_path(attraction)
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def method_name
    @attraction = Attraction.find(params[:id])
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def index
    @user = current_user
    @attractions = Attraction.all
  end

  def show
    @user = current_user
    @attraction = Attraction.find(params[:id])
  end

  def goonride
    @user = current_user
    ride = Ride.create(user_id: session[:user_id], attraction_id: params[:id])
    flash[:alert] = ride.take_ride
    redirect_to user_path(@user)
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end