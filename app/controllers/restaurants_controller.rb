class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def restaurant_params
    params[:restaurant][:user_id] = current_user.id
    params.require(:restaurant).permit(:name, :user_id)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless @restaurant.check_user current_user
      flash[:notice] = @restaurant.errors.full_messages
      redirect_to '/restaurants'
    end
  end

  def update
    restaurant = Restaurant.find(params[:id])
    if restaurant.check_user current_user
      restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant updated successfully"
    end
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.check_user current_user
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:notice] = @restaurant.errors.full_messages
    end
    redirect_to '/restaurants'
  end

end
