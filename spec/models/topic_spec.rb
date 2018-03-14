require 'rails_helper'

RSpec.describe Topic, type: :model do
  let (:title){Faker::Science.unique.element }
  let(:topic) { Topic.create!(title: title, user: user) }
  let(:user){User.create!(username: "BlocmarksUser", email: "user@blocmarks.com", password: "helloworld") }

  it { is_expected.to have_many(:bookmarks) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_length_of(:title).is_at_least(1)}

   describe "attributes" do
     it "has title and body attributes" do
       expect(topic).to have_attributes(title: title, user: user)
     end
   end
end
