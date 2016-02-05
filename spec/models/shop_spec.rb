require 'rails_helper'

RSpec.describe Shop, :type => :model do
  it "is valid with a name, a longitude, a latitude"

    it "is invalid without a name"
    it "is invalid without a longitude"
    it "is invalid without a latitude"

  describe "Type validation" do
    it "confirms longitude is a float"
    it "confirms latitude is a float"
  end

end
