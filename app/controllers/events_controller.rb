class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :current_user_is_guest, only: [:show]

  def index
    @events = current_user.events.all
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user
    @event = Event.create(event_params)
    if @event.save
      @event.user = @user
      @event.save
      flash[:notice] = "Event successfully created"
      redirect_to new_event_location_path(@event)
    else
      render :new
    end
  end

  def show
    require 'httparty'
    @user = current_user
    @event = Event.find(params[:id])
    @start = @event.start_date.to_date.strftime("%m/%d/%Y")
    @end = @event.end_date.to_date.strftime("%m/%d/%Y")
    @locations = @event.locations
    @guests = []
    @event.guests.each do |guest|
      if guest.user
        user = guest.user
        @guests.push(user)
      end
    end
    @event_guest = current_user.guests.where(event_id: @event.id).first()
    #//look over here shannon!
    if @event_guest
      @prices = {}
      if !@event.has_room(@event_guest)
        @locations.each do |location|
          @prices[location.name] = {}
          response = @event.get_hotel_info(location)
          if response["HotelInfoList"]
            @prices[location.name]['price'] = "$" + response["HotelInfoList"]["HotelInfo"]["Price"]["TotalRate"]["Value"]
          else
            @prices[location.name]['price'] = "Unavailable"
          end
          if @prices[location.name]['price'] != "Unavailable"
            @prices[location.name]['query'] = @event.expedia_url(location)
          else
            @prices[location.name]['query'] = nil
          end
        end
      end
    end
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.infowindow location.name
      marker.lat location.latitude
      marker.lng location.longitude
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.new
    if @event.update(event_params)
      flash[:notice] = "Event successfully updated"
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end

  def current_user_is_guest
    @event = Event.find(params[:id])
    unless current_user.is_guest(@event)
      flash[:error] = "You may only view your events you are attending or planning."
      redirect_to root_path
    end
  end
end
