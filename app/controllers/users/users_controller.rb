class Users::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      render "edit"
    end
  end

  #ユーザー退会確認画面用アクション
  def withdrawal
  end

  #ユーザー論理退会用アクション
  def hide
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction,:gender,:age,:is_member,:email, :profile_image,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end
end
