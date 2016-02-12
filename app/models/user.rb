class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { large: "800x600#", medium: "300x200#", thumb: "100x100#" }, default_url: "/assets/images/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :events
  has_many :guests

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

  def is_guest(event)
    if Guest.where(user_id: self.id, event_id: event.id).count > 0
      return true
    else
      return false
    end
  end
end
