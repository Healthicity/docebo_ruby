module DoceboRuby
  class Resource < OpenStruct
    def self.api=(api)
      @api = api
    end

    def self.api
      @api
    end

    def self.fetch_data(method, params = {}, &block)
      tries ||= 3
      @fetcher = API.new
      @fetcher.send_request(@api, method, params) do |result|
        return result unless block_given?
        yield result
      end
    rescue RestClient::RequestTimeout => e
      sleep (4 - tries)
      retry unless (tries -= 1).zero?
    end
  end
end
