class PostingsController < ApplicationController
  before_action :load_posting
  before_action :assert_current_user_owns, only: [:edit, :update, :destroy]
  def index
  end

  def show
    @post = Posting.find(params[:id])
    @book = @post.book
    @user = @post.user
    @shelf = @post.shelf
  end

  def create
    @posting = Posting.new(posting_params)
    @posting.user = current_user
    shelf_name = posting_params[:shelf_attributes][:name]
    if (shelf_name == "-1")
      shelf_name = new_shelf_params[:new_shelf_name]
    end
    @posting.shelf = current_user.shelves.find_or_create_by(name: shelf_name)
    @posting.save!
    redirect_to user_posting_path(current_user, @posting)
  end

  def edit
    @shelf_names = current_user.shelves.map { |shelf| shelf.name}
    @shelf_names << ["+ New Shelf", -1]
  end

  def update
    @posting = Posting.find(params[:id])
    shelf_name = posting_params[:shelf_attributes][:name]
    if (shelf_name == "-1")
      shelf_name = new_shelf_params[:new_shelf_name]
    end
    @posting.shelf = current_user.shelves.find_or_create_by(name: shelf_name)
    @posting.save!
    redirect_to @posting
  end

  def destroy
    @posting = Posting.find(params[:id])
    @posting.destroy!
    redirect_to @posting.shelf
  end


  private
  def posting_params
    post_params = params.require(:posting).permit(:quote, book_attributes: [:title, :author], shelf_attributes: [:name])
  end
  def new_shelf_params
    params.permit(:new_shelf_name)
  end
  def book_params
    params.require(:book).permit(:title, :author)
  end

  def load_posting
    @post = Posting.find(params[:id])
  end

  def assert_current_user_owns
    raise ActionController::RoutingError.new('Forbidden')  unless @post.user == current_user
  end
end
