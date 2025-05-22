class ApplicationController < ActionController::Base
  before_action :update_last_seen, if: :logged_in?
  before_action :track_page_visit
  helper_method :current_user, :logged_in?, :page_visits, :total_visits

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in."
    end
  end
  

  def page_visits
    path = request.path
    session[:page_visits] ||= {}
    session[:page_visits][path] ||= 0
    session[:page_visits][path]
  end


  def total_visits
    session[:total_visits] ||= 0
    session[:total_visits]
  end

  private
  
  def update_last_seen
    current_user.update(last_seen: Time.current) if current_user
  end
  
  def track_page_visit

    session[:page_visits] ||= {}
    
  
    path = request.path
    
   
    session[:page_visits][path] ||= 0
    session[:page_visits][path] += 1
    
   
    session[:total_visits] ||= 0
    session[:total_visits] += 1
  end
end