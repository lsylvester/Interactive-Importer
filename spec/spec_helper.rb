$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'csv-importer'
require 'rspec'
require 'rspec/autorun'
require 'active_record'
require 'sqlite3'
require 'fileutils'
FileUtils.rm 'test.db' if File.exists? 'test.db'
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'test.db')
require 'schema'
class Person < ActiveRecord::Base
end

class PersonImporter < CsvImport
end