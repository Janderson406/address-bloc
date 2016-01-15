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

#BINARY SEARCH METHOD
 def binary_search(name)
   #save the index of leftmost item in 'lower' // rightmost item 'upper'
   lower = 0
     upper = @entries.length - 1

    #loop while lower index is less or equal to our upper index
     while lower <= upper
       #Ruby truncates decimal numbers, so 5 and 0: then mid will get set to 2
       mid = (lower + upper) / 2
       mid_name = @entries[mid].name

 #if name is equal to mid_name we've found the name
 #we are looking for so we return the entry at index mid.
       if name == mid_name
         return @entries[mid]
       elsif name < mid_name #If name is alphabetically before mid_name, then we set upper to mid - 1 because the name must be in the lower half of the array.
         upper = mid - 1
       elsif name > mid_name #If name is alphabetically after mid_name, then we set lower to mid + 1 because the name must be in the upper half of the array.
         lower = mid + 1
       end
     end
  #f we divide and conquer to the point where no match is found, we return nil.
   return nil
 end

#ASSIGNMENT: ITERATIVE SEARCH
  def iterative_search(name)
    @entries.each do |search|
      if name == search.name
        return search
      end
    end
        return nil
  end

end
