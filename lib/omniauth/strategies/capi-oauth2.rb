# require 'multi_json'
# require 'omniauth/strategies/oauth2'
# require 'addressable/uri'
# TODO lookup omniauth omniauth-oauth2
# TODO http://anti-pattern.com/adding-a-new-strategy-to-omniauth
# TODO 
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class CapiOauth2 < OmniAuth::Strategies::OAuth2

      option :name, 'capi_oauth2'

      option :client_id, '92ca04c9ecdbe1a0781d138a149220ee0a020dd104822e63fd30b6ee7f65325f'
      option :client_secret, '0q29d43L6cmkSUKuSaPU8Jnppkpr5xmTocA6FTLjwAjAch2c2xImys7Hi890ARWl.dist'
      option :authorize_params, {}
      option :authorize_options, [:scope]
      # option :token_options, []
      # option :auth_token_params, {}
      # option :provider_ignores_state, false
      option :client_options, {
        :site          => 'http://localhost:5000',
        :token_url => "/oauth/token",
        :token_method => :post
      }

      option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token'
      }

      uid { raw_info['id'] }

      info do
        {
          :username => raw_info['username'],
          :email => raw_info['email'],
          :id => raw_info['id']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        binding.pry
        @raw_info ||= access_token.get('/v1/user').parsed
      end
    end
  end
end
