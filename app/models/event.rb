class Event < ActiveRecord::Base
  has_attached_file :photo, styles: {large: "800x800>" medium: "300x200#", thumb: "100x100#" }, default_url: "/assets/images/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :guests
  belongs_to :user
end
