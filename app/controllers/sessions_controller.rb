class SessionsController < ApplicationController
  def init_session
  end

  def save_session
    if params[:data].blank?
      redirect_to init_session_path
    else
      cookies[:session] = params[:data]
      redirect_to tasks_path
    end
  end

  def delete_session_cookie
    cookies.delete :session
    redirect_to init_session_path
  end
end