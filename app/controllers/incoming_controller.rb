class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!

  def create

      @user = User.find_by_email(params[:sender])
      @topic = Topic.find_by_title(params[:subject])
      @url = params["body-plain"]
      # Check if user is nil, if so, create and save a new user
  if @user.nil?
      @user = User.new(
      email: params[:sender],
      password: params[:sender],
      password_confirmation: params[:sender]
     )
     @user.save!
   end

   # Check if the topic is nil, if so, create and save a new topic
    if @topic.nil?
        @topic = @user.topics.build(title: params[:subject])
        @topic.save!
    end

       # Now that you're sure you have a valid user and topic, build and save a new bookmark
      @bookmark = @topic.bookmarks.build(url: @url)
      @bookmark.save
        head 200
  end
end
