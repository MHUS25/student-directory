@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
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

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  puts "Please enter name"
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array

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
    @students << {name: name, cohort: cohort}

    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end

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

try_load_students
interactive_menu
