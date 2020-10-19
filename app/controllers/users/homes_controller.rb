class Users::HomesController < ApplicationController

  def top
    #メンバー募集記事(10件)表示
    #ページネーションテスト用表示件数に変更中
    @recruit_members = Recruit.where(is_status: true,article_type: "メンバー募集").page(params[:page]).per(5)
    #binding.pry

    #バンド募集記事(10件)表示
    @recruit_bands = Recruit.where(is_status: true,article_type: "バンド募集").page(params[:page]).per(5)
  end

  def about
  end
end
