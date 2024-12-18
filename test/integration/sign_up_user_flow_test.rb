require "test_helper"

class SignUpUserFlowTest < ActionDispatch::IntegrationTest
  test "create new sign-up user" do
    get signup_path
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path,  params: { user: { username: "rajthakkar", email: "rajthakkar@gmail.com", password: "123456" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
  end

  test "error in creting a new sign up user" do
    get signup_path
    assert_response :success
    assert_no_difference "User.count" do
      post users_path,  params: { user: { username: "", email: "rajthakkar@gmail.com", password: "123456" } }
    end
    assert_match "issues", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
