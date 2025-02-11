class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index]

  private
  def after_sign_in_path_for(resourse)
    boards_path # ログイン後に遷移
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # ログアウト後に遷移
  end
end
