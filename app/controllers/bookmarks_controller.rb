class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @list = current_user.lists.find(params[:list_id])
    @bookmark = @list.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie added to list!"
    else
      redirect_to list_path(@list), alert: @bookmark.errors.full_messages.to_sentence
    end
  end

  def destroy
    @bookmark = Bookmark.joins(:list).where(lists: { user_id: current_user.id }).find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
