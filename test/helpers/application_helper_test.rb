class ApplicationHelperTest < ActionView::TestCase
    
  test "get current user" do
    session[:userid] = users(:one).id
    assert_instance_of User, current_user
    assert_equal users(:one), current_user
  end
  
  test "get current user if user does not exist" do
    session[:userid] = 987654321
    assert_nil current_user
  end
  
  test "get current user if no user logged in (nil)" do
    session[:userid] = nil
    assert_nil current_user
  end
  
  test "get current user if no user logged in (not set)" do
    assert_nil current_user
  end
  
end