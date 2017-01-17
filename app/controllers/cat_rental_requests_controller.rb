class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_request = CatRentalRequest.all
  end

  def new
    @cat_rental_request = CatRentalRequest.new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_req_params)
    if @cat_rental_request.save
      redirect_to cat_rental_requests_url
    else
      render json: @cat_rental_request.errors.full_messages
    end
  end


  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
  end

  private
  def cat_req_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

end
