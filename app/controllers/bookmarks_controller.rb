class BookmarksController < ApplicationController
  def show
     @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new(:topic => @topic)
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.topic_id = params[:topic_id]
    @bookmark.user = current_user
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to topic_path(params[:topic_id])
    else
      flash.now[:alert] = "Error creating bookmark. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

  end

  def update
      @topic = Topic.find(params[:topic_id])
      @bookmark = Bookmark.find(params[:id])
      @bookmark.assign_attributes(bookmark_params)
      authorize @bookmark

      if @bookmark.save
         flash[:notice] = "Bookmark was updated."
        redirect_to @topic
      else
        flash.now[:alert] = "Error saving bookmark. Please try again."
        render :edit
      end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to topic_path(@topic)
    else
      flash.now[:alert] = "There's an error deleting the bookmark"
      render topic_path(@topic)
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
