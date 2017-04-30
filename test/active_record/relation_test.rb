require 'test_helper'

require 'active_record'
require 'blog/app/models/application_record'
require 'blog/app/models/post'

class ActiveRecordTest < Minitest::Test
  def test_initialize_with_child_klass_and_where_values
    relation = Post.where("id = 2")

    assert_kind_of ActiveRecord::Relation, relation
    assert_equal Post, relation.instance_variable_get(:@klass)
    assert_equal ["id = 2"], relation.instance_variable_get(:@where_values)
  end

  def test_where_can_chain_conditions
    relation = Post.where("id = 2").where("title IS NOT NULL")
    expected_value = ["id = 2", "title IS NOT NULL"]

    assert_equal expected_value, relation.instance_variable_get(:@where_values)
  end

  def test_to_sql_returns_a_valid_sql_query_as_a_string
    query = Post.where("id = 2").where("title IS NOT NULL").to_sql
    expected_query = "SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL"

    assert_kind_of String, query
    assert_equal expected_query, query
  end

  def test_first_returns_the_first_record_that_matches_given_query
    Post.establish_connection(database: "#{__dir__}/../blog/db/development.sqlite3")
    post = Post.where("id = 2").where("title IS NOT NULL").first

    assert_equal 2, post.id
    refute_nil post.title
  end

  def test_each_returns_modified_result_after_calling_given_block_on_results
    Post.establish_connection(database: "#{__dir__}/../blog/db/development.sqlite3")
    post_ids = []
    Post.where("id IS NOT NULL").each { |post| post_ids << post.id }

    assert_equal 2, post_ids.length
    assert_equal [1, 2], post_ids
  end

  def test_length_returns_total_number_of_records_found
    Post.establish_connection(database: "#{__dir__}/../blog/db/development.sqlite3")
    posts = Post.where("id IS NOT NULL")

    assert_equal 2, posts.length
  end
end
