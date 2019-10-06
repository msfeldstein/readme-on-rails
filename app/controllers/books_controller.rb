class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new 
    @book = Book.new
    @book.postings.build
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(params.require(:book).permit(:title, :author))
    @posting = Posting.new(params.require(:book).require(:postings).permit(:quote))
    @posting.user = current_user
    @posting.book = @book
    @posting.save
    redirect_to user_posting_path(current_user, @posting)
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
