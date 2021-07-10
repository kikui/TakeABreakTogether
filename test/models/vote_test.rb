require "test_helper"

class VoteTest < ActiveSupport::TestCase

  test 'can create vote' do
    vote = create_vote
    assert_not nil, vote
  end

end
