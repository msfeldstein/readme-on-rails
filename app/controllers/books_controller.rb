class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new 
    @book = Book.new
    @posting = @book.postings.build
    @shelf_names = current_user.shelves.map { |shelf| shelf.name}
    @shelf_names << ["+ New Shelf", -1]

    pp @shelf_names
  end

  def show
    @book = Book.find(params[:id])
  end
end
