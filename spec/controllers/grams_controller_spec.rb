require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  # sets up a test that 'describes' how the grams#index action...
  describe "grams#index action" do
    # ... will behave. It should...
    # the descriptions in the strings should be useful for another developer
    # to know what you're specifying
    it "should successfully show the page" do
      # this triggers an HTTP GET request to the #index action of the
      # controller we are working with (grams)
      # the first part of the command can be: get post put patch delete
      get :index
      # verify that the page loads successfully
      # tells our tests that we expect the response to have an http status of success
      expect(response).to have_http_status(:success)
    end
  end


  describe "grams#show action" do
    it "should successfully show the page - if the gram is found" do
      # pushes a new gram into the DB
      gram = FactoryGirl.create(:gram)
      # triggers an HTTP GET request to /grams/:id, where the :id
      # is replaced by the gram we just created with FG
      get :show, id: gram.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error - if the gram is NOT found" do
      get :show, id: 'TACOCAT'
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "grams#new action" do
    it "should require users to be logged in to view the grams#new form page" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      # creates a test user & logs them in
      user = FactoryGirl.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "grams#create action" do
    it "should require users to be logged in to submit the grams#new form" do
      post :create, gram: {message: "Hello!"}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new gram in our database" do
      user = FactoryGirl.create(:user)
      sign_in user
      # will populate the 'message' field with 'Hello!' and triggers the POST request
      post :create, gram: {message: "Hello!"}
      # tells our test that we expect the user to be re-directed to the homepage
      expect(response).to redirect_to root_path

      # tells our test that we expect an item to be found in the DB, in the 
      # last/most recent spot, with a value of "Hello!" in the 'message' field
      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      # makes sure the user associated with the gram is the same as the signed-in user
      expect(gram.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, gram: {message: ""}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end

  end
end
