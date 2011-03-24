module Git2Mite
  class GitRepo
    def is_git_repo?
      status = `git status 2>&1`
      !status.downcase.include?('not a git repo')
    end
  
    def commits(start_date, end_date)
      lines = []
      IO.popen("git log --pretty=format:%ai\\|%s\\|%ae --no-merges --before=#{end_date + 1} --after=#{start_date - 1}") do |io|
        while line = io.gets
          date, message, author = line.split('|')
          lines.unshift [Date.parse(date), message.strip, author.strip]
        end
        lines
      end
    end
  end
end