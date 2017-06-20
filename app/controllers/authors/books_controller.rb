class Authors::BooksController < AuthorController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    @books = current_author.books.most_recent
  end

  def show
  end

  def new
    @book = current_author.books.new
  end

  def edit
  end

  def publish
    @book.update(published: true, published_at: Time.now)
    redirect_to authors_books_url
  end

  def unpublish
    @book.update(published: false, published_at: nil)
    redirect_to authors_books_url
  end

  def create
    @book = current_author.books.new(post_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to authors_book_path(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(post_params)
        format.html { redirect_to authors_book_path(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to authors_books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = current_author.books.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:book).permit(:author_name, :name, :content, :image, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end
end