class AboutController < ApplicationController
  def index
  	@users = User.all
  end
  def legal
  end
  def privacy
  end
end
