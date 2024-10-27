class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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

    if @user.save
      flash[:success] = "登録しました"
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
      flash[:success] = "アカウント情報を更新しました"
      redirect_to users_path
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
    params.require(:user).permit(:name, :email, :password)
  end
end
