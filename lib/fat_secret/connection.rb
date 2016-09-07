require 'active_support'
require 'active_support/core_ext/object'
require 'cgi'
require 'uri'

module FatSecret
  class Connection

    class << self
      def get(method, params)
        FatSecret.configuration.logger.debug(
          "FatSecret::Connection.get #{method} with #{params}"
        )

        access_secret = params.delete(:oauth_secret) || ''

        params = default_parameters.merge(params).merge(method: method)
        params.each do |key, value|
          params[key] = CGI.escape(value) if value.is_a?(String)
        end

        uri = request_uri('GET', params, access_secret)

        FatSecret.configuration.logger.debug(
          "FatSecret URI: #{uri}"
        )

        response = uri.read

        FatSecret.configuration.logger.debug(
          "FatSecret Response: #{response}"
        )

        JSON.parse(response)
      end

      private

      def request_uri(http_method, params, access_secret = '')
        params.merge!(oauth_signature: generate_signature(http_method, params, access_secret))
        URI.parse("#{FatSecret.configuration.uri}?#{params.to_param}")
      end

      def generate_signature(http_method, params, access_secret = '')
        signature_value(
          [
            CGI.escape(http_method), CGI.escape(FatSecret.configuration.uri),
            CGI.escape(Hash[params.sort].to_query)
          ].join('&'), access_secret
        )
      end

      def normalized_parameters(params)
        URI.encode(default_parameters.merge(params).sort.to_param)
      end

      def default_parameters
        {
          oauth_consumer_key: FatSecret.configuration.consumer_key,
          oauth_signature_method: 'HMAC-SHA1',
          oauth_timestamp: Time.now.to_i,
          oauth_nonce: SecureRandom.hex(8),
          oauth_version: '1.0',
          format: 'json'
        }
      end

      def signature_value(base_string, access_secret = '')
        digest = OpenSSL::HMAC.digest(
          OpenSSL::Digest.new('sha1'),
          "#{FatSecret.configuration.shared_secret}&#{access_secret}",
          base_string
        )
        Base64.encode64(digest).gsub(/\n/, '')
      end
    end
  end
end
