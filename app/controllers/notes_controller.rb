class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :set_note, only:[:show,:edit,:update,:destroy]

  #新規投稿用アクション
  def create
    #buileメソッドを用いてnotesコントローラのcreateアクションで、ユーザーと投稿を紐付ける
    @note = current_user.notes.build(note_params)

    if @note.save
      #保存成功時
      redirect_to note_path(@note.id), notice:"投稿が保存されました"
    else
      #保存失敗時
      @notes = Note.all.order(created_at: :desc)
      render "home/top"
    end
  end

  #詳細ページの表示用アクション
  def show
  end

  #投稿編集用アクション
  def edit
  end

  #更新用アクション
  def update
    @note.title = params[:note][:title]
    @note.content = params[:note][:content]
    @note.save

    if @note.update(note_params)
      #更新成功時
      redirect_to note_path(@note.id), notice:"投稿が更新されました"
    else
      #更新失敗時
      render :edit
    end
  end

  #削除用アクション
  def destroy
    @note.destroy

    redirect_to notes_path
  end

  #private before_action
  #指定idのレコードを取得する
  private def set_note
    @note = Note.find(params[:id])
  end

  private def note_params
    params.require(:note).permit(:title, :content)
  end

  private def correct_user
    note = Note.find(params[:id])
    #noteを投稿したユーザーを取得し、current_user?メソッドの引数に渡す
    if !current_user?(note.user)
      redirect_to root_path, alert: '許可されていないページです'
    end
  end
end
