class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    binding.pry
    render :html => "hello"
  end

end
