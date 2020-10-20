class Users::UsersController < ApplicationController
  before_action :authenticate_user!,{only: [:edit,:update,:withdrawal,:hide]}

  def show
    @user = User.find(params[:id])

    #投稿記事表示用メソッド
    @recruit_members = Recruit.where(user_id: @user.id, article_type: "メンバー募集")
    @recruit_bands = Recruit.where(user_id: @user.id,article_type: "バンド募集")
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールの編集が完了しました。"
    else
      flash.now[:alert] = "プロフィールの編集が失敗しました。"
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
    params.require(:user).permit(:id,:name,:introduction,:gender,:age,:is_member,:email, :profile_image,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end
end
