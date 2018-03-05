require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lionel)
  end

  def check_header_footer_menus
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  test "layout links not logged in" do
    get home_path
    assert_template 'static_pages/home'

    check_header_footer_menus

    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path

    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links - logged in" do
    log_in_as(@user)
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template 'users/show'

    check_header_footer_menus

    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", signup_path, count: 0

    # Account menu
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
  end
end