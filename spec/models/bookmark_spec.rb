require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:url) {Faker::Internet.url}
  let(:title){Faker::Science.unique.element }
  let(:topic) { Topic.create!(title: title, user: user) }
  let(:user){User.create!(username: "BlocmarksUser", email: "user@blocmarks.com", password: "helloworld") }
  let(:bookmark) { Bookmark.create!(url: url, topic: topic) }

  it { is_expected.to belong_to(:topic)}
  
  describe "attributes" do
      it "has a url" do
        expect(bookmark).to have_attributes(url: url, topic: topic)
      end
    end

end
