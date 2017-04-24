require 'active_record/connection_adapter'

module ActiveRecord
  class Base
    def self.abstract_class=(flag)
      #Not implemented
    end

    def self.find(id)
      # TODO: once validations are implemented
      # remove the to_i conversion
      attributes = connection.execute("SELECT * FROM posts WHERE id = #{id.to_i}").first

      new(attributes)
    end

    def self.establish_connection(options)
      @@connection = ConnectionAdapter::SqliteAdapter.new(options[:database])
    end

    def self.connection
      @@connection
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    def id
      @attributes[:id]
    end

    def title
      @attributes[:title]
    end
  end
end
