require 'test_helper'
require 'generators/usecase/usecase_generator'

class UsecaseGeneratorTest < Rails::Generators::TestCase
  tests UsecaseGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test "generator runs without errors for action" do
    assert_nothing_raised do
      run_generator ["my_usecase_action"]
    end
  end
  
  test "generator runs without errors for query" do
    assert_nothing_raised do
      run_generator ["my_usecase_query"]
    end
  end
  
  test "generator runs raises error if not action or query" do
    assert_raise do
      run_generator ["my_usecase"]
    end
  end
end
