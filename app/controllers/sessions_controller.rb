class SesssionsController < ApplicationController
  def create
      user = User.find_by(name: params[:name])
      if user.authenticate(params[:password])
        jwt = Auth.issue({user_id: user.id})
        render json: {jwt: jwt}
      end
  end
end
