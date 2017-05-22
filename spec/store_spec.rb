require 'spec_helper'

describe Store do
  # it { should have_many(:joins) }
  # it { should have_many(:brands) }

  before() do
    Brand.all.each {|brand| brand.destroy}
    Store.all.each {|store| store.destroy}
  end

  it "validates presence of a name" do
    store = Store.new(name: "")
    expect(store.save).to eq false
  end

  it "capitalizes all words before saving" do
    store = Store.create(name: "lowercase name")
    expect(store.name).to eq "Lowercase Name"
  end
end
