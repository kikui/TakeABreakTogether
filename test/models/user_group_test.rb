require "test_helper"

class UserGroupTest < ActiveSupport::TestCase

  test 'can create user_group' do
    user_group = create_user_group
    assert_not nil, user_group
  end

end
