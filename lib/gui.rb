module Git2Mite
  class Gui
    def print_welcome
      puts <<-WELCOME
  Welcome to git2mite

  This tool allows to you to write the commit log of
  your git repository to your mite account in order
  to auto-fill your timesheets.

  Brought to you by http://upstream-berlin.com
  Question, Problems, Source Code: http://github.com/upstream/git2mite
    
      WELCOME
    end

    def ask(question)
      print "#{question}: "
      gets
    end
  
    def error(reason)
      STDERR.puts reason
      exit(-1)
    end

    def get_project_id(projects)
      puts "=== Projects ==="
      projects.each.with_index do |project, i|
        puts "#{i+1}\t#{project['project']['name']}"
      end
      choice = ask('Which project do you want to write your commits to?')
      (projects[choice.to_i - 1] || error('invalid project id'))['project']['id']
    end

    def get_user_id(users)
      puts "\n=== Users ==="
      users.each.with_index do |user, i|
        puts "#{i+1}\t#{user.name}"
      end
      choice = ask('Which user do you want to write your commits to?')
      (users[choice.to_i - 1] || error('invalid user id')).id
    end
  
    def get_author(authors)
      puts "\n=== Git Authors ==="
      authors.each.with_index do |name, i|
        puts "#{i+1}\t#{name}"
      end
      choice = ask('Which author\'s commits to you want to use?')
      authors[choice.to_i - 1] || error('Invalid author')
    end
  
    def get_date(label)
      answer = ask("Enter the #{label} (yyyy-mm-dd):")
      Date.parse(answer) rescue error('invalid date')
    end
  
  end
end