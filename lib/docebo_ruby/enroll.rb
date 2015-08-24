module DoceboRuby
  class Enroll < Resource
    self.api = 'enroll'

    class << self
      def enrollments
        fetch_data('enrollments')
      end

      def count
        fetch_data('count')
      end
    end
  end
end
