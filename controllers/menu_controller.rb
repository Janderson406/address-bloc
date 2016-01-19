require_relative '../models/address_book'

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    #display the main menu options to the command line.
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Delete all entries"
    puts "6 - Exit"
    print "Enter your selection: "

   #retrieve user input from the command line using gets.
   #gets reads the next line from standard input.
    selection = gets.to_i
    case selection
    when 1
       system "clear"
       view_all_entries
       main_menu
     when 2
       system "clear"
       create_entry
       main_menu
     when 3
       system "clear"
       search_entries
       main_menu
     when 4
       system "clear"
       read_csv
       main_menu
     when 5
       system "clear"
       if @address_book.entries.count == 0
          print "There are no entries to delete\n\n"
        else
          nuke
        end
       main_menu

     when 6
       puts "Good-bye!"
      #terminate the program using exit(0).
      #'0' signals program is exiting without an error
       exit(0)
      #catch invalid user input & prompt user to retry
     else
       system "clear"
       puts "Sorry, that is not a valid input"
       main_menu
     end
   end

#methods called in main_menu. ^ ------ ^
   def view_all_entries
     @address_book.entries.each do |entry|
       system "clear"
       puts entry.to_s
       #display a submenu for each entry.
       entry_submenu(entry)
     end
     system "clear"
     puts "End of entries"
   end

   def create_entry
     system "clear"
     puts "New AddressBloc Entry"
     #prompt the user for each Entry attribute.
     print "Name: "
     name = gets.chomp
     print "Phone number: "
     phone = gets.chomp
     print "Email: "
     email = gets.chomp
     # add a new entry to @address_book ensuring that
     # the new entry is added in the proper order.
     @address_book.add_entry(name, phone, email)

     system "clear"
     puts "New entry created"
   end
#SEARCH
   def search_entries
     print "Search by name: "
     name = gets.chomp
    #call search on address_book; will either return a match or nil, it will never return an empty string since import_from_csv will fail if an entry does not have a name.
     match = @address_book.binary_search(name)
     system "clear"

     if match
       puts match.to_s
       search_submenu(match)
       #search_submenu displays a list of operations that can be performed on an Entry
     else
       puts "No match found for #{name}"
     end
   end

   def search_submenu(entry)

     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     selection = gets.chomp

     case selection
     when "d"
       system "clear"
       delete_entry(entry)
       main_menu
     when "e"
       edit_entry(entry)
       system "clear"
       main_menu
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       puts entry.to_s
       search_submenu(entry)
     end
   end
#CSV
  def read_csv
     print "Enter CSV file to import: "
     file_name = gets.chomp

     if file_name.empty?
       system "clear"
       puts "No CSV file read"
       main_menu
     end

    # begin will protect the program from crashing if an exception is thrown.
     begin
       entry_count = @address_book.import_from_csv(file_name).count
       system "clear"
       puts "#{entry_count} new entries added from #{file_name}"
     rescue
       puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
       read_csv
     end
  end

#NUKE ASSIGNMENT
  def nuke
    until address_book.entries.count <= 0
      @address_book.entries.each do |entry|
        delete_entry(entry)
      end
    end
    puts "All entries have been deleted"
  end

   def entry_submenu(entry)
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

     #chomp removes trailing whitespace from the string 'gets' returns
     selection = gets.chomp

     case selection
 # #18
     when "n"
 # #19
     when "d"
       delete_entry(entry)
     when "e"
       edit_entry(entry)
       entry_submenu(entry)
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end
   end
#DELETE
   def delete_entry(entry)
     @address_book.entries.delete(entry)
     puts "#{entry.name} has been deleted"
   end
#EDIT
   def edit_entry(entry)

     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
    # !attribute.empty? to set attributes on entry only if a valid attribute was read
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"

     puts "Updated entry:"
     puts entry
   end



end
