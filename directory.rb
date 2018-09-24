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

    puts "Now we have #{students.count} students"
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

students = input_students
print_header
print_cohort_groups(students)
print_footer(students)
