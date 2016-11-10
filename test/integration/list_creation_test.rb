require 'test_helper'

class ListCreationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:jon)
  end
  
  test "signed in user cannot create invalid list" do
    get "/users/sign_in"
    assert_response :success
    sign_in @user

    get "/lists/new"
    assert_response :success
    
    assert_no_difference '@user.lists.count' do
      post "/lists",
        params: { list: { title: "", description: "" } }
    end
    assert_response :success
    assert_select "div#error_explanation ul li", "Title can't be blank"
  end

  test "signed in user can create valid list" do
    get "/users/sign_in"
    assert_response :success
    sign_in users(:jon)

    get "/lists/new"
    assert_response :success

    assert_difference '@user.lists.count', 1 do
      post "/lists",
        params: { list: { title: "cool", description: "" } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p.notice", "List was successfully created."
  end
end
