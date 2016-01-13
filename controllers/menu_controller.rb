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
    puts "5 - Exit"
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

   def search_entries
   end

   def read_csv
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
     when "e"
 # #20
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end
   end

  end
