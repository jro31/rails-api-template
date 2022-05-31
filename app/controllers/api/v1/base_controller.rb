module Api
  module V1
    class BaseController < ApplicationController
      include CurrentUserConcern
      include Pundit

      skip_before_action :verify_authenticity_token

      after_action :verify_authorized, except: :index, unless: :skip_after_action
      after_action :verify_policy_scoped, only: :index, unless: :skip_after_action

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

      attr_reader :skip_after_action

      def user_not_authorized(exception)
        render json: {
          error_message: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
        }, status: :unauthorized
      end

      def not_found(exception)
        render json: { error_message: exception.message }, status: :not_found
      end
    end
  end
end
