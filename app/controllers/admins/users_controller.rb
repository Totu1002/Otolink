class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user.email == "guest@guest.com"
      redirect_to user_path, notice: "ゲストユーザーの編集はできません"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_users_path, notice: "プロフィールの編集が完了しました。"
    else
      flash.now[:alert] = "プロフィールの編集が失敗しました。"
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:id,:name,:introduction,:gender,:age,:is_member,:email, :profile_image,:search ,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end
end
