require "test_helper"

module Users
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    teardown do
      Users.configuration.disable_form_access = false
      Rails.application.reload_routes!
    end

    test "has new session route" do
      assert_routing "/session/new", controller: "users/sessions", action: "new"
    end

    test "does not have new session route if disable_form_access" do
      Users.configuration.disable_form_access = true
      Rails.application.reload_routes!

      assert_raise ActionController::UrlGenerationError do
        url_for(controller: "users/sessions", action: "new")
      end
    end

    test "has create session route" do
      assert_routing({ path: "/session", method: :post }, controller: "users/sessions", action: "create")
    end

    test "does not have create session route if disable_form_access" do
      Users.configuration.disable_form_access = true
      Rails.application.reload_routes!

      assert_raise ActionController::UrlGenerationError do
        url_for(controller: "users/sessions", action: "create")
      end
    end

    test "has destroy session route" do
      assert_routing({ path: "/session", method: :delete }, controller: "users/sessions", action: "destroy")
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

    test "if signed in, new session page redirects to home" do
      post session_url, params: { email_address: "one@email.com", password: "password" }
      assert cookies[:session_id].present?

      get new_session_url

      assert_redirected_to root_url
    end
  end
end
