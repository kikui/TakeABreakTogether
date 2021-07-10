require "test_helper"

class UserTest < ActiveSupport::TestCase

  test 'can create user' do
    user = create_user
    assert_not nil, user
  end

end
