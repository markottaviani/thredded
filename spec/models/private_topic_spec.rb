require 'spec_helper'

describe PrivateTopic do
  let(:user1){        Factory( :user, :name => "privateuser1" )}
  let(:user2){        Factory( :user, :name => "privateuser2" )}
  let(:messageboard){ Factory( :messageboard )}
  let(:topic){        Factory( :private_topic, messageboard: messageboard, users: [user1, user2] )}

  it "is private when it has users" do
    topic.private?.should be_true
  end
  
  context "when it is private" do
    it "does not allow someone not involved to read the topic" do
      @user3 = Factory(:user)
      ability = Ability.new(@user3)
      ability.can?(:read, topic).should be_false
    end
    it "allows someone included in the topic to read it" do
      ability = Ability.new(user2)
      ability.can?(:read, topic).should be_true
    end
  end

  describe ".add_user" do
    before(:each) do
      @joel  = Factory(:user, name: "joel")
    end
    it "should add a user by their username" do
      topic.add_user("joel")
      topic.users.should include(@joel)
    end
    it "should add a user with a User object" do
      topic.add_user(@joel)
      topic.users.should include(@joel)
    end
  end
end
