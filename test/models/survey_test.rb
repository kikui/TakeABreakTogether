require "test_helper"

class SurveyTest < ActiveSupport::TestCase

  test 'can create survey' do
    survey = create_survey
    assert_not nil, survey
  end

end
