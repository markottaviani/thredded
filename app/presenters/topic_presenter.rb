class TopicPresenter < SimpleDelegator
  def initialize(topic)
    @topic = topic
  end

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
      @users_to_sentence = @topic.users.collect { |u| u.name.capitalize }.to_sentence
    else
      ''
    end
  end
end
