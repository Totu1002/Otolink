class Users::RecruitsController < ApplicationController
  def new
  end

  def recruit_member
    @user = User.find(current_user.id)
    @recruit = Recruit.new
  end

  def recruit_band
    @user = User.find(current_user.id)
    @recruit = Recruit.new
  end

  def create
    @user = User.find(current_user.id)
    @recruit = Recruit.new(recruit_params)
    @recruit.user_id = current_user.id
    binding.pry
    if @recruit.save
      redirect_to user_path(current_user.id)
    else
      #元のpathへredirect(rails5.1~)
      redirect_to user_path(current_user.id)
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def deleate
  end

  private
  def recruit_params
    params.require(:recruit).permit(:user_id,:article_type,:title,:body,:stance,:gender,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end

end
