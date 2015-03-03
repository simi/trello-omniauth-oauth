class IntegrationsController < ApplicationController
  def index
    @token  = session['trello-oauth-token']
    @secret = session['trello-oauth-secret']
    @lists  = JSON.parse(session['trello-lists']) if session['trello-lists']
  end

  def create
    session['trello-oauth-token']  = auth_hash["credentials"]["token"]
    session['trello-oauth-secret'] = auth_hash["credentials"]["secret"]

    integration = TrelloIntegration.new(session['trello-oauth-token'], session['trello-oauth-secret'])

    session['trello-lists'] = integration.find(:members, :me).boards.map {|board|
      board.lists.collect(&:id)
    }.flatten.last(10).to_json

    redirect_to root_path, notice: 'Success'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
