class Shop < ActiveRecord::Base

  validates_presence_of :name, :longitude, :latitude
  validate :unique_coordonates

  def unique_coordonates
    if Shop.where.not(id: self.id).where(longitude: self.longitude, latitude: self.latitude).count != 0
      errors.add(:base, "The location (lat: #{self.latitude} and long:#{self.longitude}) has been already taken")
    end
  end
end
