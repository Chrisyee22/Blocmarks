class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @user_bookmarks = Bookmark.where(:user_id => current_user.id)
    @liked_bookmarks = Like.where(:user_id => current_user.id)
  end
end
