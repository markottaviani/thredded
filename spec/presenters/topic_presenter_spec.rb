require 'spec_helper'

describe TopicPresenter do
  let(:user1){ Factory( :user, :name => 'privateuser1' )}
  let(:user2){ Factory( :user, :name => 'privateuser2' )}
  let(:messageboard){ Factory( :messageboard )}
  let(:topic){ Factory(:topic) }
  let(:private_topic){ Factory( :private_topic, messageboard: messageboard, 
    users: [user1, user2] ) }

  describe '.users_to_sentence' do
    it 'should list out the users in a topic in a human readable format' do
      @private_topic = TopicPresenter.new(private_topic)
      @private_topic.users_to_sentence.should == '<cite>Privateuser1 and Privateuser2</cite>'
    end
  end

  describe '.css_class' do
    it 'should set locked if topic is locked' do
      topic.locked = true
      @topic = TopicPresenter.new(topic)
      @topic.css_class.should == 'class="locked"'
    end
    it 'should set sticky if topic is sticky' do
      topic.sticky = true
      @topic = TopicPresenter.new(topic)
      @topic.css_class.should == 'class="sticky"'
    end
    it 'should set sticky if topic is sticky' do
      @private_topic = TopicPresenter.new(private_topic)
      @private_topic.css_class.should == 'class="private"'
    end
    it 'should do all of the above' do
      private_topic.locked = true
      private_topic.sticky = true
      @private_topic = TopicPresenter.new(private_topic)
      @private_topic.css_class.should == 'class="locked sticky private"'
    end
  end
end
