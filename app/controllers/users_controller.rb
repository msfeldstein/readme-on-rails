class UsersController < ApplicationController
  require 'csv'
  def index
  end

  def show
    @user = User.find_by(username: params[:username])
    @postings = @user.postings
    @shelves = @user.shelves.where.not(:name => nil)
  end

  def show_shelf
    @user = User.find_by_username(params[:username])
    @shelf = @user.shelves.find_by_name(params[:shelfname])
    @postings = @shelf.postings
  end

  def create_shelf
    shelf = current_user.shelves.create(name: params[:name])
    redirect_to current_user
  end

  def upload_csv
    uploaded_file = params[:books]
    contents = uploaded_file.read
    user = current_user
    CSV.foreach(uploaded_file.path, headers: true) do |row_entry|
      row = row_entry.to_hash
      book = Book.new
      book.title = row["Title"]
      book.author = row["Author"]
      book.isbn = row["ISBN13"]
      shelf_name = row["Exclusive Shelf"].titlecase.sub "-", " "
      shelf = user.shelves.find_or_create_by(name: shelf_name)
      posting = shelf.postings.new
      posting.book = book
      posting.rating = row["My Rating"]
      print("Date Added")
      print(row["Date Added"])
      posting.started_on = Date.strptime(row["Date Added"], "%Y/%m/%d")
      if row["Date Read"]
        posting.finished_on = Date.strptime(row["Date Read"], "%Y/%m/%d")
      end
      posting.note = row["My Review"]
      posting.shelf = shelf
      posting.user = user
      success = posting.save!
      shelf.save!
      book.save!
    end
    user.save!
    redirect_to current_user
  end 
end
