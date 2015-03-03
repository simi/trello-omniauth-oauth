require 'trello'

class TrelloIntegration < Trello::Client
  def initialize(oauth_token, oauth_secret)
    super({
      :consumer_key => TRELLO_KEY,
      :consumer_secret => TRELLO_SECRET,
      :oauth_token => oauth_token,
      :oauth_token_secret => oauth_secret
    })
  end

  def create_notification(name, target)
    create(:card, {
      "name" => name,
      "idList" => target
    })
  end
end
