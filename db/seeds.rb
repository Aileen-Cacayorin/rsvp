User.create(email: 'test@example.com', first_name: 'Bob', last_name: 'Bobson', password: 'password1', password_confirmation: 'password1')
User.create(email: 'test2@example.com', first_name: 'Jim', last_name: 'Turner', password: 'password2', password_confirmation: 'password2')
User.create(email: 'test3@example.com', first_name: 'Mary', last_name: 'Jackson', password: 'password3', password_confirmation: 'password3')
User.create(email: 'test4@example.com', first_name: 'Lou', last_name: 'Roberts', password: 'password4', password_confirmation: 'password4')

Guest.create(user_id: 1, event_id: 1)
Guest.create(user_id: 2, event_id: 1)
Guest.create(user_id: 3, event_id: 1)
Guest.create(user_id: 4, event_id: 1)
Guest.create(user_id: 1, event_id: 2)
Guest.create(user_id: 2, event_id: 2)
Guest.create(user_id: 3, event_id: 2)
Guest.create(user_id: 4, event_id: 2)

Event.create(user_id: 1, title: "Dope Wedding", start_date: "February 20, 2016 15:00", end_date: "February 20, 2016 22:00", description: "Yo come to this wedding bruh it's gon be so tight. So many cool peeps coming and they all know how to party yo. Omg it's gon' be soooooooooo dope.")
Event.create(user_id: 2, title: "Classy Party", start_date: "August 4, 2016 14:00", end_date: "August 4, 2016 22:00", description: "This party so freaking classy. Come dressed in your most classy attire. There's gon' be so much wine and cheese and stuff. Bring your own olives.")

Location.create(name: 'Ace Hotel', street: "400 SW 6th Ave", city: "Portland", state: "OR", zip: "97204", latitude: 45.520907, longitude: -122.677505)
Location.create(name: 'The Marriott', street: "1129 SW Washington St", city: "Portland", state: "OR", zip: "97205", latitude: 45.522202, longitude: -122.683013, event_id: 1)
Location.create(name: 'Fun Room', street: "777 NE Martin Luther King Jr Blvd", city: "Portland", state: "OR", zip: "97232", latitude: 45.528362, longitude: -122.663033)
Location.create(name: 'Sky Hotel', street: "1111 NW Davis St", city: "Portland", state: "OR", zip: "97209", latitude: 45.524780, longitude: -122.682678, event_id: 2)

Room.create(start_date: "February 18, 2016 15:00", end_date: "February 22, 2016 11:00", guest_id: 1, location_id: 1, room_number: 345, event_id: 1)
Room.create(start_date: "February 18, 2016 15:00", end_date: "February 22, 2016 11:00", guest_id: 2, location_id: 1, room_number: 411, event_id: 1)
Room.create(start_date: "February 18, 2016 15:00", end_date: "February 22, 2016 11:00", guest_id: 3, location_id: 2, room_number: 119, event_id: 1)
Room.create(start_date: "February 18, 2016 15:00", end_date: "February 22, 2016 11:00", guest_id: 4, location_id: 2, room_number: 234, event_id: 1)
Room.create(start_date: "August 3, 2016 14:00", end_date: "August 6, 2016 10:00", guest_id: 5, location_id: 4, room_number: 111, event_id: 2)
Room.create(start_date: "August 3, 2016 14:00", end_date: "August 6, 2016 10:00", guest_id: 6, location_id: 4, room_number: 112, event_id: 2)
Room.create(start_date: "August 3, 2016 14:00", end_date: "August 6, 2016 10:00", guest_id: 7, location_id: 4, room_number: 113, event_id: 2)
Room.create(start_date: "August 3, 2016 14:00", end_date: "August 6, 2016 10:00", guest_id: 8, location_id: 5, room_number: 231, event_id: 2)
