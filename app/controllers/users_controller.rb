class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @notes = @user.notes
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    #アップロードされた画像を受け取り、変数fileに代入
    file = params[:user][:image]

    #user.rbのインスタンスメソッドを呼び出す
    @user.set_image(file)

    if @user.update(user_params)
      #アップデートに成功したら
      redirect_to @user, notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def correct_user
    user = User.find(params[:id])
    if !current_user?(user)
      redirect_to root_path, alert: '許可されていないページです'
    end
  end
end
