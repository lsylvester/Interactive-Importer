require 'spec_helper'

module InteractiveImporter

  describe CsvRow do
    before(:each) do
      @import = PersonImport.new(:file => File.open(File.dirname(__FILE__) + '/people.csv'))
      @import.save!
      @import.reload
      @row, @other_row = @import.csv_rows
      @row.csv_import.columns= ["first_name", "last_name"]
    end
  
    it "should create a record" do
      lambda do
        @row.import
      end.should change(Person, :count).by(1)
    end
  
    it "remember the record" do
      @row.import
      @row.record.should be_a(Person)
    end
  
    it "should have given the record attributes based on the import columns and the row content" do
      @row.import
      @row.record.first_name.should == @row.content[0]
      @row.record.last_name.should == @row.content[1]
      @other_row.csv_import.columns= ["last_name", "first_name"]
      @other_row.import
      @other_row.record.first_name.should == @other_row.content[1]
      @other_row.record.last_name.should == @other_row.content[0]
    end

    it "should delete itself after a successful import" do
      @row.import
      @row.should be_destroyed
    end
  
    it "should not delete itself after a failed successful import" do
      @row.content = ["",""] # valid data to import
      @row.import
      @row.should_not be_destroyed
    end
  
    it "should have errors like those on the record after a failed import" do
      @row.content = ["",""] # valid data to import
      @row.import
      @row.errors[:last_name].should_not be_blank
    end
  
  end
end