require 'spec_helper'

describe Brand do
  # it { should have_many(:joins) }
  # it { should have_many(:stores) }
  before() do
    Brand.all.each {|brand| brand.destroy}
    Store.all.each {|store| store.destroy}
  end

  describe 'validations and callbacks' do
    it "validates presence of name" do
      brand = Brand.new(name: "", price: 100)
      expect(brand.save).to eq(false)
    end

    it "validates presence of name" do
      brand = Brand.new(name: "")
      expect(brand.save).to eq(false)
    end

    it "validates uniqueness of name" do
      brand1 = Brand.create(name: "Nike")
      brand2 = Brand.new(name: "Nike")
      expect(brand2.save).to eq(false)
    end

    it "validates length of name is less than 100 characters" do
      brand = Brand.new(name: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

      expect(brand.save).to eq(false)
    end

    it "capitalizes all words before saving" do
      brand = Brand.new(name: "lowercase name", price: 100)
      expect(brand.name).to eq("lowercase name")
      brand.save
      expect(Brand.find(brand.id).name).to eq "Lowercase Name"
    end

    it "converts dollars to cents before saving" do
      brand = Brand.new(price: 100, name: "Nike")
      expect(brand.price).to eq 100
      brand.save
      expect(Brand.all.first.price).to eq 10000
    end
  end

  describe 'not_stores' do
    it "returns stores where the brand is not sold" do
      store = Store.create(name: "Store Name")
      brand = Brand.create(name: "Brand Name")
      expect(brand.not_stores). to eq([store])
    end
  end

  describe 'to_money' do
    it "converts a price stored in cents to a string with dollars notation" do
      brand = Brand.create price: 10000
      expect(brand.to_money).to eq "$100.00"
    end
  end
end
