require 'rails_helper'

describe Blog::BooksController do
  describe "GET #index" do
    it "populates an array of books" do
      book = FactoryGirl.create(:book, published: true, published_at: Time.now)
      get :index
      assigns(:books).should eq([book])
    end
    
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested book to @book" do
      book = FactoryGirl.create(:book, published: true, published_at: Time.now)
      get :show, id: book
      assigns(:book).should eq(book)
    end
    
    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:book, published: true, published_at: Time.now)
      response.should render_template :show
    end
  end
end