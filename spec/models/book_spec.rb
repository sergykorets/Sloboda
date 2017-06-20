require 'rails_helper'

RSpec.describe Book, type: :model do
  before(:each) do
    @author = FactoryGirl.create(:author)
    @book = FactoryGirl.create(:book, author: @author)
  end

  it "is valid with valid attributes" do
    expect(@book).to be_valid
  end

  it "is not valid without a name" do
    expect(Book.new(content: Faker::Lorem.paragraph)).not_to be_valid
  end

  it "is not valid without a content" do
    expect(Book.new(name: Faker::Lorem.paragraph)).not_to be_valid
  end

  it "has right owner" do
    expect(@book.owner?(@author)).to be(true)
  end

  it "has been removed by author" do
    expect { @book.destroy }.to change(Book, :count).by(-1)
  end
end