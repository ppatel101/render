require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
    assert_select "h1", "Users"
    assert_select "td", text: @user.name
  end

  test "should get new" do
    get new_user_url
    assert_response :success
    assert_select "h1", "Create New User"
  end

  test "should create user with valid parameters" do
    assert_difference("User.count", 1) do
      post users_url, params: {
        user: {
          name: "Daniel Craig",
          email: "daniel@example.com",
          age: 45
        }
      }
    end

    created_user = User.find_by(email: "daniel@example.com")
    assert_redirected_to user_url(created_user)
    assert_equal "User was successfully created.", flash[:notice]
  end

  test "should not create user with invalid parameters" do
    assert_no_difference("User.count") do
      post users_url, params: {
        user: {
          name: "",
          email: "invalid-email",
          age: -5
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select ".error-summary"
    assert_select "li", text: "Name can't be blank"
  end

  test "should show user details" do
    get user_url(@user)
    assert_response :success
    assert_select "h1", @user.name
    assert_select ".detail-value", text: @user.email
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
    assert_select "h1", "Edit User"
  end

  test "should update user with valid parameters" do
    patch user_url(@user), params: {
      user: {
        name: "Alice Updated",
        email: "alice_updated@example.com",
        age: 29
      }
    }

    assert_redirected_to user_url(@user)
    assert_equal "User was successfully updated.", flash[:notice]

    @user.reload
    assert_equal "Alice Updated", @user.name
    assert_equal "alice_updated@example.com", @user.email
    assert_equal 29, @user.age
  end

  test "should not update user with invalid parameters" do
    patch user_url(@user), params: {
      user: {
        name: "",
        email: "not-an-email",
        age: 0
      }
    }

    assert_response :unprocessable_entity
    assert_select ".error-summary"
    assert_select "li", text: "Name can't be blank"

    @user.reload
    assert_not_equal "", @user.name
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
    assert_equal "User was successfully deleted.", flash[:notice]
  end
end
