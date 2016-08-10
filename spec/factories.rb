FactoryGirl.define do

  # will store a user in our DB with placeholder data when we
  # use the code FactoryGirl.create(:user) in our test specs
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  # will hook up a gram factory to build a test gram record in the DB.
  # the association line means it will automatically connect the user_id of
  # the model to a user that FG will create
  factory :gram do
    message "hello"
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png'), 'image/png') }
    association :user
  end
end