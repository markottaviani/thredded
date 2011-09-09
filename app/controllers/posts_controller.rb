class PostsController < ApplicationController
  load_and_authorize_resource :only => [:index, :show]
  layout 'application'
  before_filter :pad_post, :only => :create
  helper_method :messageboard, :topic

  def create
    p = topic.posts.create(params[:post])
    redirect_to messageboard_topic_path(topic.messageboard, topic)
  end

  def edit
    authorize! :update, post
  end

  def update
    post.update_attributes(params[:post])
    redirect_to messageboard_topic_path(messageboard, topic)
  end

  def index
    @post  = topic.posts.build
    @posts = topic.posts
  end

  # ======================================
 
  def site
    @site ||= Site.where(:slug => params[:site_id]).includes(:messageboards).first
  end

  def messageboard
    @messageboard ||= site.messageboards.where(:name => params[:messageboard_id]).first
  end

  def topic
    @topic ||= messageboard.topics.find(params[:topic_id])
  end

  def post
    @post ||= topic.posts.find(params[:id]) 
  end

  def current_user_name 
    @current_user_name ||= current_user.nil? ? "anonymous" : current_user.name
  end

  # ======================================

  private

    def pad_post
      params[:post][:ip] = request.remote_ip
      params[:post][:user] = current_user_name
    end

end
