class RegistrationsController < Devise::RegistrationsController
 def create
   super do |resource|
     if resource.save && params[:event_id] !=""
       @event_id = params[:event_id]
       @event = Event.find(@event_id.to_i)
       @guest = Guest.new
       @guest.event = @event
       @guest.user = resource
       @guest.save
     end
   end
 end

 protected
 def after_sign_up_path_for(resource)
    "/users/#{resource.id}"
 end

end
