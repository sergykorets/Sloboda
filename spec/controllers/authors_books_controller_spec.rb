require 'rails_helper'

describe Authors::BooksController do
  before(:each) do
    @author = FactoryGirl.create(:author)
    sign_in(@author)
  end

  describe "GET #index" do
    it "populates an array of books" do
      book = FactoryGirl.create(:book, author: @author, published: true, published_at: Time.now)
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
      book = FactoryGirl.create(:book, author: @author, published: true, published_at: Time.now)
      get :show, id: book
      assigns(:book).should eq(book)
    end
    
    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:book, author: @author, published: true, published_at: Time.now)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a home, office, and mobile phone to the new book" do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new book" do
        expect{
          post :create, book: FactoryGirl.attributes_for(:book)
        }.to change(Book,:count).by(1)
      end
      
      it "redirects to the new book" do
        post :create, book: FactoryGirl.attributes_for(:book)
        response.should redirect_to authors_book_path(Book.last)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new book" do
        expect{
          post :create, book: FactoryGirl.attributes_for(:invalid_book)
        }.to_not change(Book,:count)
      end
      
      it "re-renders the new method" do
        post :create, book: FactoryGirl.attributes_for(:invalid_book)
        response.should render_template :new
      end
    end 
  end

  describe 'PUT update' do
    before :each do
      @book = FactoryGirl.create(:book, author: @author)
    end
    
    context "valid attributes" do
      it "located the requested @contact" do
        put :update, id: @book, book: FactoryGirl.attributes_for(:book)
        assigns(:book).should eq(@book)      
      end
    
      it "changes @book's attributes" do
        put :update, id: @book, 
          book: FactoryGirl.attributes_for(:book, name: 'updated')
        @book.reload
        @book.name.should eq("updated")
      end
    end
    
    context "invalid attributes" do
      it "locates the requested @book" do
        put :update, id: @book, book: FactoryGirl.attributes_for(:invalid_book)
        assigns(:book).should eq(@book)      
      end
      
      it "does not change @book's attributes" do
        put :update, id: @book, 
          book: FactoryGirl.attributes_for(:book, name: "Larry", content: nil)
        @book.reload
        @book.name.should_not eq("Larry")
        @book.content.should eq(@book.content)
      end
      
      it "re-renders the edit method" do
        put :update, id: @book, book: FactoryGirl.attributes_for(:invalid_book)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @book = FactoryGirl.create(:book, author: @author)
    end
    
    it "deletes the book" do
      expect{
        delete :destroy, id: @book        
      }.to change(Book,:count).by(-1)
    end
      
    it "redirects to contacts#index" do
      delete :destroy, id: @book
      response.should redirect_to authors_books_url
    end
  end
end