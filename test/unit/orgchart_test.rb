require 'test_helper'

class DoceboRuby::OrgchartTest < Minitest::Unit::TestCase

  def test_assign_users_to_node_success
    DoceboRuby::Orgchart.stubs(:fetch_data)
      .with('assignUsersToNode', assign_users_to_node_hash)
      .once

    DoceboRuby::Orgchart.assign_users_to_node(assign_users_to_node_hash)
  end

  private

  def assign_users_to_node_hash
    {id_org: 123, user_ids: [1]}
  end
end