require 'rails_helper'


RSpec.describe TopicsController, type: :controller do
  let (:title){Faker::Science.unique.element }
  let(:user){User.create!(username: "BlocmarksUser", email: "user@blocmarks.com", password: "helloworld") }
  let(:my_topic){Topic.create!( title:title, user: user)}


  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_topic to @topic" do
      get :index
      expect(assigns(:topics).include?(my_topic))
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: my_topic.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "initializes @topic" do
      get :new
      expect(assigns(:topic)).not_to be_nil
    end
  end

  describe "POST create" do

    it "increases the number of Topic by 1" do
      expect { post :create, params: { topic: { title: title, user: user }}}.to change(Topic,:count).by(1)
    end

    it "assigns the new topic to @topic" do
      post :create, params: {topic: {title: title, user: user}}
      expect(assigns(:topic)).to eq Topic.last
    end

    it "redirects to the new topic" do
      post :create, params: {topic:{ title: title, user: user}}
      expect(response).to redirect_to Topic.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
       get :edit, params: {id: my_topic.id}
       expect(response).to render_template :edit
     end
     it "assigns topic to be updated to @topic" do
       get :edit, params: {id: my_topic.id}
       topic_instance = assigns(:topic)

       expect(topic_instance.id).to eq my_topic.id
       expect(topic_instance.title).to eq my_topic.title
     end
  end

  describe "DELETE destroy" do
    it "deletes the topic" do
      delete :destroy, params:{ id: my_topic.id }
      count = Topic.where({ id: my_topic.id}).size
      expect(count).to eq 0
    end

    it "redirects to topics index" do
      delete :destroy, params:{ id: my_topic.id }
      expect(response).to redirect_to topics_path
    end
  end

end
