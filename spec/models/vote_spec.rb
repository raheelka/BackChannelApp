require 'spec_helper'

describe Vote do

  before do
    # This code is not idiomatically correct.
    @vote = Vote.new(user_id: "1", post_id: "1"  )    #see how user_id shud be passed
  end

  subject { @vote }

  it { should respond_to(:user_id) }
  it { should respond_to(:post_id) }


end
