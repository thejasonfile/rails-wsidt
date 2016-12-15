class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
      user = User.find_by(name: params[:user][:name])
      if user.authenticate(params[:user][:password])
        jwt = Auth.issue({user_id: user.id})
        render json: {jwt: jwt}
      else
        render json: {error: 'Please check username and password.'}
      end
  end
end
