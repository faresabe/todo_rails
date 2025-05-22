module ApplicationHelper
    module ApplicationHelper
        def format_last_seen(time)
          return "Just now" unless time
          
          seconds_ago = Time.current - time
          
          case seconds_ago
          when 0..59
            "#{seconds_ago.to_i} seconds ago"
          when 60..3599
            minutes = (seconds_ago / 60).to_i
            "#{minutes} #{minutes == 1 ? 'minute' : 'minutes'} ago"
          when 3600..86399
            hours = (seconds_ago / 3600).to_i
            "#{hours} #{hours == 1 ? 'hour' : 'hours'} ago"
          else
            days = (seconds_ago / 86400).to_i
            "#{days} #{days == 1 ? 'day' : 'days'} ago"
          end
        end
      end
end
