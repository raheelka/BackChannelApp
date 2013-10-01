require 'spec_helper'

describe Post do

  before do
    # This code is not idiomatically correct.
    @post = Post.new(content: "Lorem ipsum", weight: 1000, category: "", tag: "" )    #see how user_id shud be passed
  end

  subject { @post }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:weight) }
  it { should respond_to(:category) }
  it { should respond_to(:tag) }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @post.content = "a" * 161 }
    it { should_not be_valid }
  end
end
