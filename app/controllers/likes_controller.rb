class LikesController < ApplicationController


  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = Topic.find(params[:topic_id])
    like = current_user.likes.build(bookmark: @bookmark)

    authorize like

    if like.save
      flash[:notice] = "Like was saved successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error creating like. Please try again."
    redirect_to @topic
    end
  end

  def destroy
    @bookmark = Bookmark.find(param[:bookmark_id])
    @topic = Topic.find(params[:topic_id])
    like = Like.find_by(:user_id => current_user.id, :bookmark_id => params[:bookmark_id])

    authorize like

    if like.destroy
      flash[:notice] = "Like was deleted successfully."
      redirect_to @topic
    else
      flash.now[:alert] =  "There was an error deleting the like"

    redirect_to @topic
   end
  end

end
