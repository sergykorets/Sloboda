class Blog::BooksController < BlogController

  def index
 	  if params[:category].present?
      @books = last_week_published.tagged_with(params[:category]).page params[:page]
 	  else
      @books = last_week_published.page params[:page]
    end
  end

  def show
    puts last_week_published.inspect
    if !last_week_published.blank?
      @book = last_week_published.friendly.find(params[:id])
    else
      redirect_to root_path, notice: 'Book was published more than one week ago'
    end
  end

  private

  def last_week_published
  	Book.published.last_week.most_recent
  end
end