$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'bundler/setup'
Bundler.require(:test)
require 'csv-importer'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'test.db')
require 'schema'
class Person < ActiveRecord::Base
  validates :last_name, :presence => true
end

class PersonImport < CsvImport
end