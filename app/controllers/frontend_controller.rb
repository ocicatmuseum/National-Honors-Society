class FrontendController <  ApplicationController
  layout "frontend"
  helper Lipsiadmin::View::Helpers::FrontendHelper
  #before_filter :frontend_login_required
  def index
    redirect_to :controller => 'frontend/base'
  end
end