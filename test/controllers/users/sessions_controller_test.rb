require "test_helper"

module Users
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "renders sign in form" do
      get new_session_url

      assert_response :success
    end

    test "creates session if valid credentials" do
      assert_difference("Users::Session.count") do
        post session_url, params: { email_address: "one@email.com", password: "password" }
      end

      assert_redirected_to root_url
      assert_equal "Welcome back!", flash[:notice]
      assert cookies[:session_id].present?
    end

    test "does not create session if invalid credentials" do
      assert_no_difference("Users::Session.count")  do
        post session_url, params: { email_address: "", password: "" }
      end

      assert_redirected_to new_session_url
      assert_equal "Try another email address or password.", flash[:alert]
      assert_not cookies[:session_id].present?
    end

    test "destroys session" do
      post session_url, params: { email_address: "one@email.com", password: "password" }
      assert cookies[:session_id].present?

      delete session_url

      assert_equal "You have been signed out correctly.", flash[:alert]
      assert_redirected_to new_session_url
      assert_not cookies[:session_id].present?
    end
  end
end
