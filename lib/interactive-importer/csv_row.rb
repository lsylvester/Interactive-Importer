module InteractiveImporter
  class CsvRow < ActiveRecord::Base
    serialize :content
    belongs_to :csv_import, :inverse_of => :csv_rows
  
    def import
      if csv_import.columns.include?("id")
        id = content[columns.index("id")]
        @record = csv_import.target_class.find_by_id(id)
        if @record
          @record.update_attributes(to_hash)
        else
          @record = csv_import.target_class.create to_hash
        end
      else
        @record = csv_import.target_class.create to_hash
      end
      destroy unless @record.new_record?
    end
  
    attr_reader :record
  
    delegate :importable_columns, :columns, :to => :csv_import
  
    delegate :each, :to => :content
    include Enumerable
  
    def errors
      @record ? @record.errors : super
    end
  
    def to_hash
      {}.tap do |hash|
        importable_columns.each do |column|
          if columns.include?(column)
            hash[column] = content[columns.index(column)]
          end
        end
      end
    end
  end
end