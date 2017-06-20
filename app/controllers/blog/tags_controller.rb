class Blog::TagsController < BlogController

  def index
    @categories = Tag.order("taggings_count DESC").search(params[:search]).page params[:page]
  end
end