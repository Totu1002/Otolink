class Admins::RecruitsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @recruits = Recruit.all
  end

  def show
    @recruit = Recruit.find(params[:id])
    @user = User.find_by(id: @recruit.user_id)
  end

  def edit
    @recruit = Recruit.find(params[:id])
  end

  def update
    @recruit = Recruit.find(params[:id])
    if @recruit.update(recruit_params)
      redirect_to admins_recruits_path, notice: "記事の編集が完了しました。"
    else
      #元のpathへredirect
      flash.now[:alert] = "記事の編集に失敗しました。"
      render "edit"
    end
  end

  def destroy
    @recruit = Recruit.find(params[:id])
    @recruit.destroy
    redirect_to admins_recruits_path, notice: "記事の削除が完了しました。"
  end

  private
  def recruit_params
    params.require(:recruit).permit(:user_id,:article_type,:title,:body,:stance,:gender,:is_status,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end

end
