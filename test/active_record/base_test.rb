require 'test_helper'

require 'active_record'
require 'blog/app/models/application_record'
require 'blog/app/models/post'

class ActiveRecordTest < Minitest::Test
  def setup
    Post.establish_connection(database: "#{__dir__}/../blog/db/development.sqlite3")
  end

  def test_find_returns_post_with_matching_id
    post = Post.find(1)
    assert_kind_of Post, post
    assert_equal 1, post.id
    assert_equal "Blueberry Muffins", post.title
  end

  def test_all_returns_all_posts
    posts = Post.all
    assert_kind_of Array, posts
    assert_equal 2, posts.length
    assert_equal 1, posts.first.id
    assert_equal "Blueberry Muffins", posts.first.title
  end

  def test_initialize_with_valid_params_creates_object_with_params
    post = Post.new(id: 1, title: "My first post")

    assert_equal 1, post.id
    assert_equal "My first post", post.title
  end
end
