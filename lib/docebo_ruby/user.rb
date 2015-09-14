module DoceboRuby
  class User < Resource
    self.api = 'user'

    class << self
      def create(attributes = {})
        fetch_data('create', attributes)
      end

      def check_username(username)
        fetch_data('checkUsername', {userid: username})
      end

      def get_token(username)
        fetch_data('getToken', { username: username })
      end

      def authenticate(username, password)
        fetch_data('authenticate', {password: password, username: username}) do |response|
          response['id_user'] || false
        end
      end

      def sso_url(username)
        timestamp = Time.now.to_i
        token = Digest::MD5.hexdigest([username, timestamp, DoceboRuby.config.sso_token].join(','))
        "http://#{DoceboRuby.config.saas_url}/doceboLms/index.php?auth_regen=1&modname=login&op=confirm&login_user=#{username}&time=#{timestamp}&token=#{token}"
      end
    end
  end
end
