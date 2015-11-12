class Public::BaseController < ::ApplicationController

  before_action :test_action

  def test_action
    @hello = 'Hello world'
  end

  def index

  end

end
