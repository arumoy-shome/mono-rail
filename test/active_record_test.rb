require 'test_helper'

require 'active_record'
require 'blog/app/models/application_record'
require 'blog/app/models/post'

class ActiveRecordTest < Minitest::Test
  def test_#initialize_with_valid_params
    post = Post.new(id: 1, title: "My first post")

    assert_equal 1, post.id
    assert_equal "My first post", post.text
  end

  def test_#initialize_with_nil_params
    post = Post.new(id: 2)

    assert_equal 2, post.id
    assert_equal nil, post.text
  end
end
