class LocationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = current_user.events.all
  end

  def new
    @user = current_user
    @event = Event.find(params[:event_id])
    @location = Location.new
  end

  def create
    binding.pry
    @user = current_user
    @event = Event.find(params[:event_id].to_i)
    @name = params[:name]
    @street = params[:address]
    @city = params[:city]
    @state = params[:state]
    @location = Location.create(:name => @name, :street => @street, :city => @city, :state => @state, :event_id => params[:event_id].to_i)

    if @user == @event.user
      redirect_to user_event_path(@user, @event)
    else
      @start_date = @event.start_date
      @end_date = @event.end_date
      @guest = @event.find_guest(@user).id
      binding.pry
      @room = Room.create(:start_date => @start_date, :end_date => @end_date, :location_id => @location.id, :event_id => @event.id, :guest_id => @guest)
      @room.save
      redirect_to user_event_path(@user, @event)
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def location_params
    params.require(:location).permit(:name, :street, :state, :city, :address_components)
  end
end
