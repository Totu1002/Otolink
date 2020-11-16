class Users::UsersController < ApplicationController
  before_action :authenticate_user!,{only: [:edit,:update,:withdrawal,:hide]}

  def show
    @user = User.find(params[:id])

    #投稿記事表示用メソッド
    @recruit_members = Recruit.where(user_id: @user.id, article_type: "メンバー募集")
    @recruit_bands = Recruit.where(user_id: @user.id, article_type: "バンド募集")

    if user_signed_in?
      #DM機能用メソッド
      #Entryモデルよりログインユーザーのレコード取得
      @current_entry = Entry.where(user_id: current_user.id)
      #Entryモデルより相手ユーザーのレコード取得
      @another_entry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id
              #DM用roomが存在する場合
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        #DM用roomが存在しない場合
        unless @is_room
          #RoomとEntryを新規作成
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
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
    @user = current_user
  end

  #ユーザー論理退会用アクション
  def hide
    @user = current_user
    @user.update(is_member: "無効")
    #sessionIDのresetを行う
    reset_session
    redirect_to home_path
  end

  def search
    #指定した条件により分岐しユーザーを絞り込む
    #scopeを用いた方がよい可読性が向上する

    #ページ初期表示
    @users = User.where(is_member: "有効").page(params[:page]).per(10)

    if params[:name].present?
      @users = User.where(['name LIKE ?', "%#{params[:name]}%"]).page(params[:page]).per(10)
    end

    if params[:gender].present?
      @users = @users.where(gender: params[:gender]).page(params[:page]).per(10)
    end

    #指定した活動地域に紐付くユーザーを取得
    if params[:prefecture_ids].present?
      users_pref = UsersPrefecture.where(prefecture_id: params[:prefecture_ids])
      users_pref_id = users_pref.select("user_id")
      @users = @users.where(id: users_pref_id).page(params[:page]).per(10)
    end

    #指定したパートに紐付くユーザーを取得
    if params[:part_ids].present?
      users_part = UsersPart.where(part_id: params[:part_ids])
      users_part_id = users_part.select("user_id")
      @users = @users.where(id: users_part_id).page(params[:page]).per(10)
    end

    #指定したジャンルに紐付くユーザーを取得
    if params[:genre_ids].present?
      users_genre = UsersGenre.where(genre_id: params[:genre_ids])
      users_genre_id = users_genre.select("user_id")
      @users = @users.where(id: users_genre_id).page(params[:page]).per(10)
    end
  end

  #お気に入り機能
  #自身がお気に入り登録中のユーザーを表示
  def following
    @user  = User.find(params[:id])
    @users = @user.following_user
  end

  #自身をお気に入り登録中のユーザーを表示
  #現在未使用アクション
  def followers
    @user  = User.find(params[:id])
    @users = @user.follower_user
  end

  private
  def user_params
    params.require(:user).permit(:id,:name,:introduction,:gender,:age,:is_member,:email, :profile_image,:search ,:prefecture_ids => [],:part_ids => [],:genre_ids => [])
  end
end
