class GmailerController < ApplicationController

  def enable
    render json: { action: 'goto', url: '/auth/google_oauth2' }
  end
end
