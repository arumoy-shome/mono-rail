module ActiveRecord
  class Relation
    def initialize(klass)
      @klass = klass
      @where_values = []
    end

    def where!(condition)
      @where_values << condition

      self
    end

    def where(condition)
      clone.where!(condition)
    end

    def to_sql
      sql = "SELECT * FROM #{@klass.table_name}"

      if @where_values.any?
        sql << " WHERE #{@where_values.join(" AND ")}"
      end

      sql
    end

    def first
      records.first
    end

    def each(&block)
      records.each(&block)
    end

    def length
      records.length
    end

    private

    def records
      @records ||= @klass.find_by_sql(to_sql)
    end
  end
end
