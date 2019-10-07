class PostingsController < ApplicationController
  def index
  end

  def show
    @post = Posting.find(params[:id])
    @book = @post.book
    @user = @post.user
  end

  def create
    pp params.to_unsafe_h
    post_params = params.require(:posting).permit(:quote, book_attributes: [:title, :author], shelf_attributes: [:name])
    print(post_params)
    @posting = Posting.new(post_params)
    @posting.user = current_user
    shelf_name = post_params[:shelf_attributes][:name]
    if (shelf_name == "-1")
      shelf_name = new_shelf_params[:new_shelf_name]
    end
    @posting.shelf = current_user.shelves.find_or_create_by(name: shelf_name)
    @posting.save!
    # @book = Book.new(params.require(:book).permit(:title, :author))
    # @posting = Posting.new(params.require(:book).require(:postings).permit(:quote))
    # @posting.user = current_user
    # @posting.book = @book
    # @posting.save
    redirect_to user_posting_path(current_user, @posting)
  end


  private
  def new_shelf_params
    params.permit(:new_shelf_name)
  end
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
