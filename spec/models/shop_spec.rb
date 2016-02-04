require 'rails_helper'

RSpec.describe Shop, :type => :model do
  it "is valid with a name, a longitude, a latitude"

  context "Not valid" do
    it "is invalid without a name"
    it "is invalid without a longitude"
    it "is invalid without a latitude"
  end
end
