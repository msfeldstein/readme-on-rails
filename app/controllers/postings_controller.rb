class PostingsController < ApplicationController
  def index
  end

  def show
    @post = Posting.find(params[:id])
    @book = @post.book
    @user = @post.user
  end
end
