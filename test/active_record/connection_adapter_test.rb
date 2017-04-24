require 'test_helper'

require 'active_record'

class ActiveRecord::ConnectionAdapterTest < Minitest::Test
  def setup
    file = "#{ __dir__ }/../blog/db/development.sqlite3"

    @db = ActiveRecord::ConnectionAdapter::SqliteAdapter.new(file)
  end

  def test_#initialize
    assert @db
    assert_kind_of ActiveRecord::ConnectionAdapter::SqliteAdapter, @db
  end

  def test_#execute_returns_result_as_hashes_within_an_array
    result = @db.execute('SELECT * FROM posts')

    assert result
    assert_kind_of Array, result
    assert_kind_of Hash, result.first
  end

  def test_#columns_returns_column_names_of_table_as_an_array
    columns = @db.columns('posts')

    assert columns
    assert_kind_of Array, columns
    assert_equal [:id, :title, :body, :created_at, :updated_at], columns
  end
end
