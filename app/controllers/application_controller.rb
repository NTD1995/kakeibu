class ApplicationController < ActionController::Base
  # ログイン後に遷移したいページを指定  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_top_path
    when User
      root_path
    else
      root_path
    end
  end

  # ログアウト後に遷移したいページを指定
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      about_path
    end
  end

end