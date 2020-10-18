class Users::RecruitsController < ApplicationController
  def new
  end

  #メンバー募集ページ用アクション
  def recruit_member
    @user = User.find(current_user.id)
    @recruit = Recruit.new
  end

  #バンド募集ページ用アクション
  def recruit_band
    @user = User.find(current_user.id)
    @recruit = Recruit.new
  end

  def create
    @user = User.find(current_user.id)
    @recruit = Recruit.new(recruit_params)
    @recruit.user_id = current_user.id
    if @recruit.save
      redirect_to user_path(current_user.id), notice: "記事の投稿が完了しました。"
    else
      #元のpathへredirect
      case @recruit.article_type
        when "メンバー募集"
          flash.now[:alert] = "記事の投稿に失敗しました。"
          render "recruit_member"
        when "バンド募集"
          flash.now[:alert] = "記事の投稿に失敗しました。"
          render "recruit_band"
      end
    end
  end

  def show
    @recruit = Recruit.find(params[:id])
  end

  def edit
    @recruit = Recruit.find(params[:id])
  end

  def update
    @recruit = Recruit.find(params[:id])
    if @recruit.update(recruit_params)
      redirect_to user_path(current_user.id), notice: "記事の編集が完了しました。"
    else
      #元のpathへredirect
      flash.now[:alert] = "記事の編集に失敗しました。"
      render "edit"
    end
  end

  def destroy
    @recruit = Recruit.find(params[:id])
    @recruit.destroy
    redirect_to user_path(current_user.id), notice: "記事の削除が完了しました。"
  end

  private
  def recruit_params
    params.require(:recruit).permit(:user_id,:article_type,:title,:body,:stance,:gender,:is_status,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end

end
