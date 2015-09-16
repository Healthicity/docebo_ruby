module DoceboRuby
  class Enroll < Resource
    self.api = 'enroll'

    class << self
      def enrollments(options = {})
        fetch_data('enrollments', options)
      end

      def count(options = {})
        fetch_data('count', options)
      end
    end
  end
end
