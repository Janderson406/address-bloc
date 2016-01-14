require_relative 'entry'
#load library entry.rb relative to address_book.rb's file path
require "csv"

class AddressBook
 attr_accessor :entries

 def initialize
   @entries = []
 end

 def add_entry(name, phone_number, email)

   index = 0
   @entries.each do |entry|
     if name < entry.name
       break
     end
     index += 1
   end

   @entries.insert(index, Entry.new(name, phone_number, email))
   #insert a new entry into entries using the calculated `index
 end

 def import_from_csv(file_name)
   csv_text = File.read(file_name)  #reading the file, using File.read
   csv = CSV.parse(csv_text, headers: true, skip_blanks: true) #use the CSV class to parse the file.
   #The result of CSV.parse is an object of type CSV::Table (Class Method?)
   csv.each do |row|
     row_hash = row.to_hash #create a hash for each row
     add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
     #convert each row_hash to an Entry by using the add_entry method
   end
 end


end
