require 'test_helper'

require 'active_record'
require 'blog/app/models/application_record'
require 'blog/app/models/post'

class ActiveRecordTest < Minitest::Test
  def test_find_with_id_returns_post_with_matching_id
    Post.establish_connection(database: "#{ __dir__ }/blog/db/development.sqlite3")

    post = Post.find(1)
    assert_kind_of Post, post
    assert_equal 1, post.id
    assert_equal "Blueberry Muffins", post.title
  end

  def test_establish_connection_creates_a_db_connection_and_returns_it
    connection = Post.establish_connection(database: "#{ __dir__ }/blog/db/development.sqlite3")

    assert connection
    assert_kind_of ActiveRecord::ConnectionAdapter::SqliteAdapter, connection
  end

  def test_#initialize_with_valid_params_creates_object_with_params
    post = Post.new(id: 1, title: "My first post")

    assert_equal 1, post.id
    assert_equal "My first post", post.title
  end

  def test_#initialize_with_nil_params_creates_object_with_nil_params
    post = Post.new(id: 2)

    assert_equal 2, post.id
    assert_nil post.title
  end
end
