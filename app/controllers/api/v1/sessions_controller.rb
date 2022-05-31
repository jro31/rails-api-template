module Api
  module V1
    class SessionsController < Api::V1::BaseController
      skip_after_action :verify_authorized

      # POST /api/v1/sessions
      def create
        user = User.find_by(email: params['user']['email'])
                   .try(:authenticate, params['user']['password'])

        raise 'Incorrect username/password' unless user

        session[:user_id] = user.id
        render json: {
          logged_in: true,
          user: UserRepresenter.new(user).as_json
        }, status: :created
      rescue StandardError => e
        render json: { error_message: e.message }, status: :unauthorized
      end

      # GET /api/v1/logged_in
      def logged_in
        if @current_user
          render json: {
            logged_in: true,
            user: UserRepresenter.new(@current_user).as_json
          }, status: :ok
        else
          render json: {
            logged_in: false
          }, status: :ok
        end
      end

      # DELETE /api/v1/logout
      def logout
        reset_session
        render json: { logged_out: true }, status: :ok
      end
    end
  end
end
