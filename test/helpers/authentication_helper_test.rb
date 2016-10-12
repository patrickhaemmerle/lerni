class AuthenticationHelperTest < ActionView::TestCase
    
  test "current_user" do
    session[:userid] = users(:one).id
    assert_instance_of User, current_user
    assert_equal users(:one), current_user
  end
  
  test "current_user if user does not exist" do
    session[:userid] = 987654321
    assert_nil current_user
  end
  
  test "current_user if no user logged in (nil)" do
    session[:userid] = nil
    assert_nil current_user
  end
  
  test "current_user if no user logged in (not set)" do
    assert_nil current_user
  end
  
  test "logged_in? true" do
    session[:userid] = users(:one).id
    assert logged_in?
  end
  
  test "logged_in? false" do
    assert_not logged_in?
  end
  
  test "logged_in? inexstent user" do
    session[:userid] = 123
    assert_not logged_in?
  end
  
end