class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :user_liked, only: [:show]
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.jpg"

    if @user.save
      if params[:user][:image_name]
        # @user.image_name = "#{@user.id}.jpg"
        @user.update(image_name: "#{@user.id}.jpg")
        File.binwrite("public/user_images/#{@user.image_name}",params[:user][:image_name].read)
        @user.save
      end

      flash[:success] = "登録しました"
      log_in @user
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      if params[:user][:image_name]
        # @user.image_name = "#{@user.id}.jpg"
        @user.update(image_name: "#{@user.id}.jpg")
        File.binwrite("public/user_images/#{@user.image_name}",params[:user][:image_name].read)
        @user.save
      end
      flash[:success] = "アカウント情報を更新しました"
      redirect_to users_path(@user, updated_at: Time.current.to_i)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to action: :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to action: :new
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_name)
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
      redirect_to @user
    end
  end

  def user_liked
    liked = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.where(id: liked)
  end

end
