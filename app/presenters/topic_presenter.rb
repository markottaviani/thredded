class TopicPresenter
  def initialize(topic)
    @topic = topic
  end

  attr_reader :topic
  delegate :created_at, :last_user, :locked, :sticky, :posts, :posts_count, 
    :title, :updated_at, :to_param, :user, :user_name, to: :topic

  def css_class
    @classes = []
    @classes << 'locked' if @topic.locked
    @classes << 'sticky' if @topic.sticky
    if @classes.empty?
      ''
    else
      "class=\"#{@classes.join(' ')}\"".html_safe
    end
  end

  def users_to_sentence
    if @topic.class == 'PrivateTopic' && @topic.users
      content_tag :cite do
        @users_to_sentence = @topic.users.collect { |u| u.name.capitalize }.to_sentence
      end
    else
      ''
    end
  end
end
