class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:name], email: params[:email])
    if @user && @user.authenticate(params[:password])
      log_in(@user)
      redirect_to root_path
    else
      flash.now[:error] = "ログインに失敗しました"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to signin_path
  end
end
