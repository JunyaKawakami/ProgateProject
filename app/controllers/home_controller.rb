class HomeController < ApplicationController
  def top
    if user_signed_in?
      # 変数@noteにNoteクラスのインスタンスを代入してください
      @note = Note.new
      # 変数@notesにNoteクラスのインスタンスの配列を降順で代入してください
      @notes = Note.all.order(created_at: :desc)
    else
      @message = "ようこそGatebookへ！"
    end
  end

  def about
  end
end
