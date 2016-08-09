# will store a user in our DB with placeholder data when we
# use the code FactoryGirl.create(:user) in our test specs

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
end