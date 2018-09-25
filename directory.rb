def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end


def input_students
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  puts "Please enter name"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array

    while true do
      puts "Please enter cohort"
      cohort = gets.chomp.downcase.capitalize
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
    students << {name: name, cohort: cohort}

    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end

    # get another name from the user
    puts "Please enter name"
    name = gets.chomp
  end
  # return the array of students
 students
end
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_cohort_groups(students)

  sorted_by_cohort = {}

  students.each do |student|
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

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

interactive_menu
if students.count == 0
  puts "There are no students"
else
print_header
print(students)
print_footer(students)
end
