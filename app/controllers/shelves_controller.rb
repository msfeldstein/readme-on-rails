class ShelvesController < ApplicationController
  before_action :load_shelf_and_user
  def show
    @postings = @shelf.postings.order("updated_at DESC")
  end

  private
  def load_shelf_and_user
    @shelf = Shelf.find(params[:id])
    @user = @shelf.user
  end
end
