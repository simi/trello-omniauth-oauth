require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Trello < OmniAuth::Strategies::OAuth

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
          :site => "https://trello.com/1",
          :request_token_path => '/OAuthGetRequestToken',
          :authorize_path     => '/OAuthAuthorizeToken',
          :access_token_path  => '/OAuthGetAccessToken'
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['fullName'],
          :email => raw_info['email'],
          :username => raw_info['username']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/members/me').body)
      end
    end
  end
end
