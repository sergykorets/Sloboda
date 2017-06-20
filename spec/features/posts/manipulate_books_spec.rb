require 'rails_helper'

feature 'Creating a new book' do
  background do
    @author = FactoryGirl.create(:author)
    visit new_author_session_path
    fill_in 'email', with: @author.email
    fill_in 'password', with: @author.password
    click_button 'login'
  end

  scenario 'The new book form is filled in correctly' do
    visit new_authors_book_path

    find('#book_name').set('test title')
    find('#book_content').set('test content')
    
    expect { click_button 'Save' }.to change { Book.count }.by(1)
    expect(current_path).to eq(authors_post_path(Book.last))

    visit authors_books_path
    expect(page).to have_content('test title')
  end

  scenario 'The edit book form is filled in correctly' do
    book = FactoryGirl.create(:book, author: @author)
    visit edit_authors_book_path(book)

    find('#book_name').set('test title updated')
    find('#book_content').set('test content updated')
    click_button 'Save'

    visit authors_books_path
    expect(page).to have_content('test title updated')
  end

  scenario 'book remove' do
    book = FactoryGirl.create(:book, author: @author)
    visit authors_books_path

    expect { click_link 'Remove' }.to change { Book.count }.by(-1)

    visit authors_books_path
    expect(page).not_to have_content(book.name)
  end

  scenario 'book publish' do
    book = FactoryGirl.create(:book, author: @author)
    visit authors_posts_path

    click_link 'Publish'

    visit root_path
    expect(page).to have_content(book.name)
  end

  scenario 'book to draft' do
    book = FactoryGirl.create(:book, author: @author)
    visit authors_books_path
    click_link 'Publish'
    visit root_path
    expect(page).to have_content(book.name)

    visit authors_books_path
    click_link 'To draft'
    visit root_path
    expect(page).not_to have_content(book.name)
  end
end
