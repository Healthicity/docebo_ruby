require 'rest_client'
require 'json'
require 'digest/sha1'
require 'base64'

module DoceboRuby
  class API
    def initialize
      @url = DoceboRuby.config.api_url
      @key = DoceboRuby.config.api_key
      @secret = DoceboRuby.config.api_secret
    end

    def send_request(api, method, params, &block)
      raise ArgumentError.new('Please specify parameters') if params.nil?
      parameters = Parameters.new params
      options = request_options parameters
      url = rest_url api, method

      RestClient.post(url, params, options) do |raw_response|
        case raw_response.code
          when 404
            raise NotFound.new(raw_response)
          when 500
            raise RequestError.new({url: url, method: method, params: params, raw_response: raw_response}.to_s)
          else
            response = parse_response raw_response
            if block_given?
              yield response
            else
              return response
            end
        end
      end
    end

    protected

    def parse_response(raw_response)
      if raw_response.present?
        JSON.parse(raw_response)
      else
        { 'code' => raw_response.code }
      end
    end

    def rest_url(api, method)
      if api == '' || method == ''
        raise ArgumentError.new('You need to specify a module / method') 
      end
      "#{@url}/#{api}/#{method}"
    end

    def code(parameters)
      codice = Digest::SHA1.hexdigest "#{parameters.to_s},#{@secret}"
      code = Base64.strict_encode64 "#{@key}:#{codice}"
      "Docebo #{code}"
    end

    def request_options(parameters)
      {
        content_type: :json, 
        accept: :json, 
        'X-Authorization' => code(parameters)
      }
    end
  end
end
