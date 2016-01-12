require_relative 'entry'
#load library entry.rb relative to address_book.rb's file path

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

 def remove_entry(name, phone_number, email)
     @entries.delete_if {|entry| name == entry.name && phone_number == entry.phone_number && email == entry.email}
 end


end
