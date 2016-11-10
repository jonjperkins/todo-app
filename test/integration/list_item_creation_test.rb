require 'test_helper'

class ListItemCreationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:jon)
    @list = lists(:one)
  end
  
  test "signed in user cannot create invalid list item" do
    get "/users/sign_in"
    assert_response :success
    sign_in @user

    get "/lists/1"
    assert_response :success
    
    assert_no_difference '@list.items.count' do
      post "/lists/1/items",
        params: { item: { content: ""}, list_id: "1"  }
    end
    assert_response :redirect
  end

  test "signed in user can create valid list item" do
    get "/users/sign_in"
    assert_response :success
    sign_in @user

    get "/lists/1"
    assert_response :success
    
    assert_difference '@list.items.count', 1 do
      post "/lists/1/items",
        params: { item: { content: "help people"}, list_id: "1"  }
    end
    assert_response :redirect
  end

end
