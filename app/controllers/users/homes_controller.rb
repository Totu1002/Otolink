class Users::HomesController < ApplicationController

  def top
    #有効のユーザーのみ表示
    user = User.where(is_member: "有効")
    #メンバー募集記事(10件)表示
    #ページネーションテスト用表示件数に変更中
    @recruit_members = Recruit.where(is_status: true,article_type: "メンバー募集",user_id: user.ids).page(params[:page]).per(5)

    #バンド募集記事(10件)表示
    @recruit_bands = Recruit.where(is_status: true,article_type: "バンド募集",user_id: user.ids).page(params[:page]).per(5)
  end

  def about
  end

end
