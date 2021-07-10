require "test_helper"

class GroupTest < ActiveSupport::TestCase

  test 'can create group' do
    group = create_group
    assert_not nil, group
  end

end
