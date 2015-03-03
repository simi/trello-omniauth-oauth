require 'omniauth/strategies/trello'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :trello, TRELLO_KEY, TRELLO_SECRET,
    authorize_params: {
      scope: 'read,write',
      expiration: 'never',
      name: 'Trello OmniAuth OAuth test'
    }
end
