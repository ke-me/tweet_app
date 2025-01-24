class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if post.user_id != current_user&.id
    @like = Like.new(
      user_id: current_user&.id,
      post_id: params[:post_id]
    )
    @like.save
    else
      flash[:alert] = "自分の投稿にはいいねできません"
    end
    redirect_to request.referer
  end

  def destroy
    @like = Like.find_by(
      user_id: current_user.id,
      post_id: params[:post_id]
    )
    @like.destroy
    redirect_to request.referer
  end

  # private

  # def like_params
  #   params.require(:like).permit(:user_id, :post_id)
  # end
end
