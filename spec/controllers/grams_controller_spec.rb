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

  describe "grams#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    it "should successfully create a new gram in our database" do
      # will populate the 'message' field with 'Hello!' and triggers the POST request
      post :create, gram: {message: "Hello!"}
      # tells our test that we expect the user to be re-directed to the homepage
      expect(response).to redirect_to root_path

      # tells our test that we expect an item to be found in the DB, in the 
      # last/most recent spot, with a value of "Hello!" in the 'message' field
      gram = Gram.last
      expect(gram.message).to eq("Hello!")

    end
  end
end
