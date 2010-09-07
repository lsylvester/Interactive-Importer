module InteractiveImporter
  class CsvRow < ActiveRecord::Base
    serialize :content
    belongs_to :csv_import, :inverse_of => :csv_rows
  
    def import
      if @record = record_to_merge
        update_record
      else
        create_record
      end
    end
    
    def update_record
      if @record.update_attributes(to_hash)
        update_attribute(:state, 'merged')
      else
        update_attribute(:state, 'error')
      end
    end
    
    def record_to_merge
      if csv_import.columns.include?("id")
        id = content[columns.index("id")]
        csv_import.target_class.find_by_id(id)
      end
    end
    
    def create_record
      @record = csv_import.target_class.create to_hash
      if @record.new_record?
        update_attribute(:state, 'error')
      else
        update_attribute(:state, 'added')
      end
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
    
    STATES = %w(added merged new error)
    
    STATES.each do |state|
      define_method "#{state}?".to_sym do
        state == self.state
      end
    end
  end
end