require 'csv'

@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  if @students.count == 0
    puts "There are no students"
  else
  print_header
  print_students_list()
  print_footer
  end
end

def process(selection)
  case selection
    when "1"
      puts "Inputing the students ..."
      input_students
    when "2"
      puts "Showing the students ..."
      show_students
    when "3"
      puts "Saving the list to file ..."
      save_students
    when "4"
      puts "Loading the list from file..."
      load_students
    when "9"
      puts "Exiting the program ..."
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def save_students
  # ask user for filename
  puts "Enter the name of file you would like to save the data to"
  filename = STDIN.gets.chomp
  # open the file for writing
  CSV.open(filename, "a") do |csv|
    # iterate over the array of students
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv << student_data
  # file = File.open("#{filename}", "w") do |file|
  # # iterate over the array of students
  #   @students.each do |student|
  #     student_data = [student[:name], student[:cohort]]
  #     csv_line = student_data.join(",")
  #     file.puts csv_line
    end
  end
end

def add_to_hash(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def load_students
  # ask user for filename
  puts "Enter the name of file you would like to load the data from"
  filename = STDIN.gets.chomp
  # open file for reading
  CSV.foreach(filename) do |row|
    name, cohort = row[0], row[1]
    add_to_hash(name, cohort)
  # file = File.open("#{filename}", "r") do |file|
  #   file.readlines.each do |line|
  #     name, cohort = line.chomp.split(',')
  #     add_to_hash(name, cohort)
  #   end
  end
end


def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil?  # set filename to students.csv if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_student_count
  if @students.count == 1
    puts "Now we have 1 student"
  else
    puts "Now we have #{@students.count} students"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  puts "Please enter name"
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    while true do
      puts "Please enter cohort"
      cohort = STDIN.gets.chomp.downcase.capitalize
      case cohort.downcase
      when "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"
        break
      when ""
        cohort = "N/A"
        break
      else
        puts "Incorrect spelling"
      end
    end
    add_to_hash(name, cohort)
    print_student_count
    # get another name from the user
    puts "Please enter name"
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list()
  @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_cohort_groups

  sorted_by_cohort = {}

  @students.each do |student|
  		cohort = student[:cohort]

  		name = student[:name]

  		if sorted_by_cohort[cohort] == nil
  				sorted_by_cohort[cohort] = [name]
  		else
  				sorted_by_cohort[cohort].push(name)
  		end
  end
  puts sorted_by_cohort.to_s.tr('{}"">[]', '').gsub!('=', ', ').split(',')
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

interactive_menu
