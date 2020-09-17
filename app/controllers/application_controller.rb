class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # deviseのpermitted_parameterを追加する
    def configure_permitted_parameters
      # sign_upを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar] )
    end
end
