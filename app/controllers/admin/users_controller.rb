class Admin::UsersController < Admin::BaseController
  def index
    @page_title    = 'Users'
    @users         = User.all
    @users         = @users.send(params[:scope]) if params[:scope].present?
    @scopes        = {
      'All'    => nil,
      'Recent' => 'recent',
    }
  end
end
