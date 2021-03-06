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

    it "should be marked as added after a successful import" do
      @row.import
      @row.state.should == "added"
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
    
    it "should update an existing row if it matches based on id" do
      @existing_person = Person.create(:first_name => "Old First Name", :last_name => "Old Last Name")
      @row.content = [@existing_person.id,"New First Name","New Last Name"]
      @row.csv_import.columns= ["id","first_name", "last_name"]
      lambda {
        @row.import
      }.should_not change(Person, :count)
      @existing_person.reload
      @existing_person.first_name.should == "New First Name"
      @existing_person.last_name.should == "New Last Name"
      @row.state.should == 'merged'
    end
  
  end
end