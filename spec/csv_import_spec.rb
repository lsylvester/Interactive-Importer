require 'spec_helper'

describe PersonImport do
  it "should have available columns from the people table" do
    PersonImport.new.importable_columns.should == %w(first_name last_name)
  end
  
  it "should have target class Person" do
    PersonImport.new.target_class.should == Person
  end
  
  describe "when loaded with a csv file" do
    before(:each) do
      @import = PersonImport.new(:file => File.open(File.dirname(__FILE__) + '/people.csv'))
      @import.save!
    end
    
    it "should have generated to csv_rows" do
      @import.should have(2).csv_rows 
    end
    
  end
end