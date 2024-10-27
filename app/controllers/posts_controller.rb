class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = "投稿しました"
      redirect_to posts_path
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to action: :new
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
