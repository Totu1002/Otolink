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
    @user = User.find_by(id: @recruit.user_id)
  end

  def edit
    @recruit = Recruit.find(params[:id])
    #対象ユーザーがカレントユーザーか確認
    if @recruit.user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
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

  def index
    @page_title = "投稿記事一覧"
    @recruits = Recruit.where(is_status: true)
  end

  def search
    #指定した条件により分岐し記事を絞り込む
    #scopeを用いた方がよい可読性が向上する

    #ページ初期表示
    @recruits =  Recruit.where(is_status: true).page(params[:page]).per(10)

    #指定した記事種別に紐付いた記事を取得
    if params[:article_type].present?
      @recruits = @recruits.where(article_type: params[:article_type]).page(params[:page]).per(10)
    end

    #指定した活動方針に紐付いた記事を取得
    if params[:stance].present?
      @recruits = @recruits.where(stance: params[:stance]).page(params[:page]).per(10)
    end

    #指定した活動地域に紐付く記事を取得
    if params[:prefecture_ids].present?
      recruits_pref = RecruitsPrefecture.where(prefecture_id: params[:prefecture_ids])
      recruits_pref_id = recruits_pref.select("recruit_id")
      @recruits = @recruits.where(id: recruits_pref_id).page(params[:page]).per(10)
    end

    #指定したパートに紐付く記事を取得
    if params[:part_ids].present?
      recruits_part = RecruitsPart.where(part_id: params[:part_ids])
      recruits_part_id = recruits_part.select("recruit_id")
      @recruits = @recruits.where(id: recruits_part_id).page(params[:page]).per(10)
    end

    #指定したジャンルに紐付く記事を取得
    if params[:genre_ids].present?
      recruits_genre = RecruitsGenre.where(genre_id: params[:genre_ids])
      recruits_genre_id = recruits_genre.select("recruit_id")
      @recruits = @recruits.where(id: recruits_genre_id).page(params[:page]).per(10)
    end
  end

  private
  def recruit_params
    params.require(:recruit).permit(:user_id,:article_type,:title,:body,:stance,:gender,:is_status,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end

end
