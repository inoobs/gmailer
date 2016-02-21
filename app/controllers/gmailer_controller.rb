class GmailerController < ApplicationController

  def enable
    render json: { action: 'goto', url: '/auth/google_oauth2' }
  end

  def fetch_mails
    debts = Gmailer::Fetcher.get_mails(
      params['credentials']['token'], params['info']['email'], params['due'],
      params['amount'], params['from']
    )
    render json: debts
  end
end
