class AboutController < ApplicationController
  def about
  	@users = User.all
  end
  def legal
  end
  def privacy
  end
end
