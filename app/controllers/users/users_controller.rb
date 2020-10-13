class Users::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
  end

  def update
  end

  #ユーザー退会確認画面用アクション
  def withdrawal
  end

  #ユーザー論理退会用アクション
  def hide
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction,:gender,:age,:area,:part,:genre,:is_member,:email)
  end
end
