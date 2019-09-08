class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # ログインユーザーのみアクセスできるようにする
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "Login is needed."
      redirect_to("/login")
    end
  end

  # ログインユーザーがアクセスできないようにする
  def forbid_login_user
    if @current_user
      flash[:notice] = "Already logged in."
      redirect_to("/problems")
    end
  end

  # ユーザーの編集を制限
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = ""
      redirect_to("/users")
    end
  end
end
