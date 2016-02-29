class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { large: "800x600#", medium: "300x200#", thumb: "100x100#" }, default_url: "/assets/images/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :events, dependent: :destroy
  has_many :guests

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


 # creates list of events a user is a guest of
  def attending
    attending = []
    user_id = self.id
    guests = Guest.where(user_id: user_id)
    guests.each do |guest|
      event = guest.event
      attending.push(event)
    end
    return attending
  end

  # checks if a user is a guest of an event
  def is_guest(event)
    if Guest.where(user_id: self.id, event_id: event.id).count > 0
      return true
    else
      return false
    end
  end

  #checks if a user owns the event
  def is_event_planner(event)
    if Event.where(id: event.id, user_id: self.id).count > 0
      return true
    else
      return false
    end
  end

  def full_name
    return self.first_name + ' ' + self.last_name
  end


  #searches for guest by either name or email
  def self.search(search)
    if search != nil
      User.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      []
    end

  end


end
