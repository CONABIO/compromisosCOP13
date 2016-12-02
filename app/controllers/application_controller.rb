class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Limita la aplicacion a un usuario y contrasenia general
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["USERNAME_ADMIN"].to_s && password == ENV["PASSWORD_ADMIN"].to_s
    end
  end
end
