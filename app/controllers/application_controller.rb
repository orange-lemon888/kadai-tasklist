class ApplicationController < ActionController::Base
    
  include SessionsHelper
  
  private

  #ログイン済みユーザかどうか確認
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end