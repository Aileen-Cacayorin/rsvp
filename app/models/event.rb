class Event < ActiveRecord::Base

  has_attached_file :photo, styles: {large: "800x800>", medium: "300x200#", thumb: "100x100#" }, default_url: "/assets/images/missing.jpg"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/


  has_many :guests, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :rooms, dependent: :destroy
  belongs_to :user


  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  validates :start_date, :presence => true
  validates :end_date, :presence => true

  def find_guest(user)
    event_id = self.id
    return Guest.where(user_id: user.id, event_id: event_id).first
  end

  def get_hotel_info(location)
    return  HTTParty.get("http://terminal2.expedia.com/x/hotels?hotelids=" + location.hotelid + "&dates=" + self.start_date.strftime("%Y-%m-%d") + "," + self.end_date.strftime("%Y-%m-%d") + "&apikey=" + "3FD8jYfm0LbZsxOcVZ66f89vByNPKXQB")
  end

  def has_room(guest)
    return guest.rooms.where(event_id: self.id).any?
  end

  def expedia_url(location)
    return 'https://www.expedia.com/' + location.city + '-Hotels-' + location.name.split(' ').join('-') + '.h' +    location.hotelid + '.Hotel-Information?chkin=' + self.start_date.strftime("%m").to_s + '%2F' + self.start_date.strftime("%d").to_s + '%2F' + self.start_date.strftime("%Y").to_s + '&chkout=' + self.end_date.strftime("%m").to_s + '%2F' + self.end_date.strftime("%d").to_s + '%2F' + self.end_date.strftime("%Y").to_s
  end

  def description_preview
    description.length > 300 ? description[0...300] : description
  end

end
