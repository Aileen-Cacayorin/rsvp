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

    else
      @guest = @event.find_guest(@user).id

      if @location.event_location_exists(@event)   #if location exists, guest room with location_id is saved
        @room_location = @location.get_existing_location(@event)

      else #if location does not exist, saves location and adds guest room
        @location.save
        @room_location = @location
      end
      @room = Room.create(:start_date => @event.start_date, :end_date => @event.end_date, :location_id => @room_location.id, :event_id => @event.id, :guest_id => @guest)
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
