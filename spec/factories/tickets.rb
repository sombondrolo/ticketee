FactoryBot.define do
  factory :ticket do
    name { "Example ticket" }
    description { "An example ticket, nothing more" }
    association :author, factory: :user
    # a_different_user = FactoryBot.create(:user, email: "different@example.com")
    # FactoryBot.create(:ticket, author: a_different_user)
  end
end
