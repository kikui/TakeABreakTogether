require "test_helper"

class ProposalTest < ActiveSupport::TestCase

  test 'can create proposal' do
    proposal = create_proposal
    assert_not nil, proposal
  end

end
