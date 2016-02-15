class Location < ActiveRecord::Base
  before_create :get_hotelid

  attr_accessor :full_address
  belongs_to :event
  has_many :rooms, dependent: :destroy
  has_many :guests, through: :rooms

  geocoded_by :full_address
  after_validation :geocode

  validates :name, :presence => true
  validates :street, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true


  def full_address
    "#{street}, #{city}, #{state}"
  end


  #gets expedia hotel id
  def get_hotelid
    self.city = self.city.strip()
    self.state = self.state.strip()
    query = self.name.split(' ').join('-') + "-" + self.city + '-' + self.state
    response = HTTParty.get("http://terminal2.expedia.com/x/nlp/results?q=" + query + "&apikey=" + "3FD8jYfm0LbZsxOcVZ66f89vByNPKXQB")
    self.hotelid = response["result"]["hotels"].first()["id"]
  end

  #determines is a location already exists for an event based on hotelid
  def event_location_exists(event)
    self.get_hotelid()
    if Location.where(:event_id => event.id, :hotelid => self.hotelid).count > 0
      return true
    else
      return false
    end
  end

  #returns existing location for event
  def get_existing_location(event)
    self.get_hotelid()
    return Location.where(:event_id => event.id, :hotelid => self.hotelid).first
  end

end
