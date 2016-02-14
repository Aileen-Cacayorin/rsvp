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
    @user = current_user
    @event = Event.find(params[:event_id].to_i)
    @name = location_params[:name]
    @address = params[:search].split(",")
    @street = @address[0]
    @city = @address[1]
    @state = @address[2]
    @location = Location.new(:name => @name, :street => @street, :city => @city, :state => @state, :event_id => params[:event_id].to_i)

    #saves location if this is the main event location. need to fix this for when event owner adds personal travel plans/room
    if @user == @event.user
      @location.save

    #if location already exists, location is not saved but the guests room with corresponding location_id is saved
    elsif @location.event_location_exists(@event)
      @existing_location = @location.get_existing_location(@event)
      @start_date = @event.start_date
      @end_date = @event.end_date
      @guest = @event.find_guest(@user).id
      @room = Room.create(:start_date => @start_date, :end_date => @end_date, :location_id => @existing_location.id, :event_id => @event.id, :guest_id => @guest)
      @room.save

    #if location does not exist, saves location and adds guest room
    else
      @location.save
      @start_date = @event.start_date
      @end_date = @event.end_date
      @guest = @event.find_guest(@user).id
      @room = Room.create(:start_date => @start_date, :end_date => @end_date, :location_id => @location.id, :event_id => @event.id, :guest_id => @guest)
      @room.save
    end
    redirect_to user_event_path(@user, @event)
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
    params.require(:location).permit(:name, :search, :name, :street, :state, :city)
  end
end
