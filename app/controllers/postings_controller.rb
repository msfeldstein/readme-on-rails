class PostingsController < ApplicationController
  before_action :load_posting, only: [:show, :edit, :update, :destroy]
  before_action :assert_current_user_owns, only: [:edit, :update, :destroy]
  def index
  end

  def new 
    @post = Posting.new
    @book = @post.book = Book.new
    @shelf_names = current_user.shelves.map { |shelf| shelf.name}
    @shelf_names << ["+ New Shelf", -1]
  end

  def show
    @book = @post.book
    @user = @post.user
    @shelf = @post.shelf
  end

  def create
    @post = Posting.new(posting_params)
    @post.user = current_user
    shelf_name = posting_params[:shelf_attributes][:name]
    if (shelf_name == "-1")
      shelf_name = new_shelf_params[:new_shelf_name]
    end
    @post.shelf = current_user.shelves.find_or_create_by(name: shelf_name)
    @post.save!
    redirect_to user_posting_path(current_user, @post)
  end

  def edit
    @shelf_names = current_user.shelves.map { |shelf| shelf.name}
    @shelf_names << ["+ New Shelf", -1]
  end

  def update
    shelf_name = posting_params[:shelf_attributes][:name]
    if (shelf_name == "-1")
      shelf_name = new_shelf_params[:new_shelf_name]
    end
    @post.update_attributes(posting_params)
    @post.shelf = current_user.shelves.find_or_create_by(name: shelf_name)
    @post.touch
    @post.save!
    redirect_to @post
  end

  def destroy
    @post.destroy!
    redirect_to @post.shelf
  end


  private
  def posting_params
    params.require(:posting).permit(
      :cover,
      book_attributes: [:id, :title, :author],
      shelf_attributes: [:id, :name],
      notes_attributes: [:id, :body, :note_type, :_destroy])
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
