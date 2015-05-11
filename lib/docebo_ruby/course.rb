module DoceboRuby
  class Course < Resource
    self.api = 'course'

    class << self
      def all
        courses = fetch_data('listCourses') do |data|
          data.delete_if { |key, value| key == 'success' }
        end
        courses.map { |key, value| Course.new value['course_info']  }
      end

      def add_user_subscription(attributes)
        fetch_data('addUserSubscription', attributes)
      end
    end
  end
end
