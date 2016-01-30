User.create(email: 'test@example.com', first_name: 'Bob', last_name: 'Bobson', password: 'passy', password_confirmation: 'passy')
User.create(email: 'test2@example.com', first_name: 'Jim', last_name: 'Turner', password: 'passy', password_confirmation: 'passy')
User.create(email: 'test3@example.com', first_name: 'Mary', last_name: 'Jackson', password: 'passy', password_confirmation: 'passy')
User.create(email: 'test4@example.com', first_name: 'Lou', last_name: 'Roberts', password: 'passy', password_confirmation: 'passy')

Guest.create(user_id: 1, event_id: 1)
Guest.create(user_id: 2, event_id: 1)
Guest.create(user_id: 3, event_id: 1)
Guest.create(user_id: 4, event_id: 1)
Guest.create(user_id: 1, event_id: 2)
Guest.create(user_id: 2, event_id: 2)
Guest.create(user_id: 3, event_id: 2)
Guest.create(user_id: 4, event_id: 2)

Event.create(user_id: 1, title: "Dope Wedding", description: "Yo come to this wedding bruh it's gon be so tight. So many cool peeps coming and they all know how to party yo. Omg it's gon' be soooooooooo dope.")
Event.create(user_id: 2, title: "Classy Party", description: "This party so freaking classy. Come dressed in your most classy attire. There's gon' be so much wine and cheese and stuff. Bring your own olives.")

Location.create(name: 'Ace Hotel', start_date: "February 21, 2016 12:00", end_date: "February 21, 2016 18:00"
, street: "400 SW 6th Ave", city: "Portland", state: "OR", zip: "97204", latitude: 45.520907, longitude: -122.677505, event_id: 1)
Location.create(name: 'The Marriott', start_date: "February 18, 2016 08:00", end_date: "February 22, 2016 18:00"
, street: "1129 SW Washington St", city: "Portland", state: "OR", zip: "97205", latitude: 45.522202, longitude: -122.683013, event_id: 1, guest_id: 2)
Location.create(name: 'My Basement', start_date: "February 21, 2016 12:00", end_date: "February 23, 2016 18:00"
, street: "1313 NW Marshall St", city: "Portland", state: "OR", zip: "97209", latitude: 45.530895, longitude: -122.684814, event_id: 2)
Location.create(name: 'Fun Room', start_date: "August 5, 2016 14:00", end_date: "August 5, 2016 20:00"
, street: "777 NE Martin Luther King Jr Blvd", city: "Portland", state: "OR", zip: "97232", latitude: 45.528362, longitude: -122.663033, event_id: 2)
Location.create(name: 'Sky Hotel', start_date: "August 3, 2016 09:00", end_date: "August 6, 2016 19:00"
, street: "1111 NW Davis St", city: "Portland", state: "OR", zip: "97209", latitude: 45.524780, longitude: -122.682678, event_id: 2, guest_id: 3)
