module DoceboRuby
  class Orgchart < Resource
    self.api = 'orgchart'
    class << self
      def create_node(attributes = {})
        fetch_data('createNode', attributes)
      end

      def find_node_by_code(code)
        fetch_data('findNodeByCode', { code: code})
      end

      def delete_node(id_org)
        fetch_data('deleteNode', { id_org: id_org })
      end

      def find_node_by_code(code)
        fetch_data('findNodeByCode', { code: code })
      end
    end
  end
end
