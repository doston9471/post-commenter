class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @post.save
        redirect_to posts_path
      else
        render :index
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end