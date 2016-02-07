require 'rails_helper'

RSpec.describe Shop, :type => :model do
  it "is valid with a name, a longitude, a latitude" do
    shop = Shop.new(
      name: "Shopmium Test",
      latitude: "50.8647",
      longitude: "2.3453")

    expect(shop).to be_valid
  end

  it "is invalid without a name" do
    shop = Shop.new(
      name: nil,
      latitude: "50.8647",
      longitude: "2.3453")

    shop.valid?
    expect(shop.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a latitude" do
    shop = Shop.new(
      name: "Shopmium Test",
      latitude: nil,
      longitude: "2.3453")

    shop.valid?
    expect(shop.errors[:latitude]).to include("can't be blank")
  end

  it "is invalid without a longitude" do
    shop = Shop.new(
      name: "Shopmium Test",
      latitude: "50.8647",
      longitude: nil)

    shop.valid?
    expect(shop.errors[:longitude]).to include("can't be blank")

  end

  it "is invalid with duplicate longitude/latitude" do
    Shop.create(
      name: "Shopmium Test",
      latitude: "50.5647",
      longitude: "2.3456")

    shop = Shop.new(
      name: "Shopmium Test1",
      latitude: "50.5647",
      longitude: "2.3456")

    shop.save
    expect(shop.errors[:base][0]).to include("has been already taken")

  end

  describe "phone number" do
    before :each do
      @shop_test = Shop.create(
        name: "Shopmium Test",
        latitude: "50.5647",
        longitude: "2.3453"
      )
    end

    it "is valid with length of 10" do
     @shop_test.phone = "0123456789"
     expect(@shop_test).to be_valid
    end

    it "is invalid with length smaller than 10" do
      @shop_test.phone = "0145367"
      @shop_test.valid?
      expect(@shop_test.errors[:phone][0]).to include("is the wrong length")
    end

    it "is invalid with length greater than 10" do
      @shop_test.phone = "0145368764356797"
      @shop_test.valid?
      expect(@shop_test.errors[:phone][0]).to include("is the wrong length")
    end

  end

end
