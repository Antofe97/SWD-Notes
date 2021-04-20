class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    protected
    def is_normal_user?
        user_signed_in? && current_user.is_normal_user?
    end
    
    def is_admin?
        user_signed_in? && current_user.is_admin?
    end

end
