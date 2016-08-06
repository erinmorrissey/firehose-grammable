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
end
