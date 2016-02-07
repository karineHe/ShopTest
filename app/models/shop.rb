class Shop < ActiveRecord::Base
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  validates_presence_of :name, :longitude, :latitude
  validate :unique_coordonates
  validate :phone

  def unique_coordonates
    if Shop.where.not(id: self.id).where(longitude: self.longitude, latitude: self.latitude).count != 0
      errors.add(:base, "The location (lat: #{self.latitude} and long:#{self.longitude}) has been already taken")
    end
  end
end
