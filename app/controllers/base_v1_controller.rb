class BaseV1Controller < ApplicationController
    before_action :configure_permitted_parameters, if: :devise_controller?  
    around_action :switch_locale

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name is_admin])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name is_admin])
    end

    def authenticate_user!
      unless user_signed_in?
        render json: { message: 'Error', error: ['Not authorized'] }, status: :unauthorized
      end
    end

    def authorize_admin!
      unless current_user&.user_type == 'admin'
        render json: { message: 'Error', error: ['Not authorized, admin access required'] }, status: :forbidden
      end
    end

    private 

    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
end
