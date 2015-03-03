class NotificationsController < ApplicationController
  def create
    integration = TrelloIntegration.new(session['trello-oauth-token'], session['trello-oauth-secret'])

    begin
      integration.create_notification(params[:name], params[:list_id])

      redirect_to root_url, notice: 'Notification created!'
    rescue Trello::Error => e
      Rails.logger.warn(e.message)
      redirect_to root_url, alert: 'Notification not created!', error: e.message
    end
  end

end
