class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build(review_params)
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  #
  #     flash[:notice] = "You have reviewed this restaurant already!"
  #   else
  #     @restaurant.reviews.create(review_params)
  #   end
  #     redirect_to restaurants_path
  # end

  def review_params
    params[:review][:user_id] = current_user.id
    params.require(:review).permit(:thoughts, :rating, :user_id)
  end

end
