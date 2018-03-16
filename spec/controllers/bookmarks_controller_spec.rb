require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:title){Faker::Science.unique.element }
  let(:user){User.create!(username: "BlocmarksUser", email: "user@blocmarks.com", password: "helloworld") }
  let (:url){Faker::Internet.url}
  let(:my_topic){Topic.create!( title:title, user: user)}
  let(:my_bookmark){Bookmark.create!(url: url, topic: my_topic)}

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { topic_id: my_topic.id, id: my_bookmark.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params:  { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
        get :new, params: { topic_id: my_topic.id }
        expect(response).to render_template :new
      end

    it "intializes @bookmark" do
      get :new, params: { topic_id: my_topic.id}
      expect(assigns(:bookmark)).not_to be_nil
    end
  end

  describe "POST create" do

    it "increases the number of Bookmark by 1" do
      expect { post :create, params: {topic_id: my_topic.id, bookmark: { url: url, topic: my_topic }}}.to change(Bookmark,:count).by(1)
    end

    it "assigns the new bookmark to @bookmark" do
      post :create, params: {topic_id: my_topic.id, bookmark: {url: url, topic: my_topic}}
      expect(assigns(:bookmark)).to eq Bookmark.last
    end

    it "redirects to the new bookmark" do
      post :create, params: { topic_id: my_topic.id, bookmark: {url: url, topic: my_topic}}
      expect(response).to redirect_to [my_topic]
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit,  params: { topic_id: my_topic.id, id: my_bookmark.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_bookmark.id }
      expect(response).to render_template :edit
    end

    it "assigns bookmark to be updated to @bookmark" do
      get :edit, params: { topic_id: my_topic.id, id: my_bookmark.id }
      bookmark_instance = assigns(:bookmark)

       expect(bookmark_instance.id).to eq my_bookmark.id
       expect(bookmark_instance.url).to eq my_bookmark.url
    end
  end
  describe "PUT update" do
       it "updates bookmark with expected attributes" do
         new_url = url
         topic = my_topic

put :update, params: { topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url, topic: topic } }

       updated_bookmark = assigns(:bookmark)
       expect(updated_bookmark.id).to eq my_bookmark.id
       expect(updated_bookmark.url).to eq new_url
       expect(updated_bookmark.topic).to eq topic
    end

    it "redirects to updated bookmark " do
      new_url = url
      topic = my_topic

      put :update, params: { topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url, topic: my_topic } }
      expect(response).to redirect_to [my_topic]
     end
  end

  describe "DELETE destroy" do
    it "deletes the bookmark" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_bookmark.id}
      expect(response).to redirect_to my_topic
    end
  end

end
