require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @activated = users(:archer)
    @non_activated = users(:lana)
  end

  test "show user redirects if user not activated" do
    log_in_as @activated

    get user_path(@activated)
    assert_template 'users/show'

    get user_path(@non_activated)
    assert_redirected_to root_url
  end

end