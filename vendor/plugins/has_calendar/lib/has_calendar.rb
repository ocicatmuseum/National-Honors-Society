module SimplesIdeias
  module Calendar
    module ActionView
      def calendar(options={}, &block)
        options = {
          :year => Date.today.year,
          :month => Date.today.month,
          :today => nil,
          :events => nil,
          :field => :created_at,
          :header_format => :day_of_week,
          :caption_format => :default,
          :id => "calendar"
        }.merge(options)
        
        day_letter = "A"
        cmd = 'cal '
        cmd << '-m ' unless RUBY_PLATFORM =~ /darwin/
      
        # execute the command
        output = IO.popen("#{cmd} #{options[:month]} #{options[:year]}").read
      
        # get calendar lines
        io = StringIO.new(output)
        lines = io.readlines
        lines = lines[2, lines.size-3]
        lines.map!(&:chomp)
      
        # strip spaces from each day and group them
        days = lines.inject([]) do |holder, line|
          0.step(line.size, 3) do |n|
            holder << line[n, 3].squish
          end
          holder
        end
        days.unshift(nil)
        
        # group all records if data is provided
        if options[:events]
          records = options[:events].inject({}) do |memo, record|
            stamp = record.send(options[:field]).to_date.to_s(:number)
            memo[stamp] ||= []
            memo[stamp] << record
            memo
          end
        end
      
        # building the calendar
        contents = content_tag(:table, :id => options[:id], :class => 'calendar') do
          # first, get the header
          today = Date.today
          date = today.beginning_of_week
          date = date - 1.day if RUBY_PLATFORM =~ /darwin/
        
          caption = content_tag(:caption, Date::MONTHNAMES[options[:month]])
        
          head = content_tag(:thead) do
            content_tag(:tr) do
              (0..6).collect { |i| content_tag(:th, Date::DAYNAMES[i]) } * ""
            end
          end
        
          # then get the body
          rows = ""
          days.in_groups_of(7, "") do |group|
            rows << content_tag(:tr) do
              group.inject("") do |cols, day|
                col_options = {:class => 'day', :style => (!day.blank?)? 'cursor:pointer;':''}
                events = ""
                weekend = false
                unless day.blank?
                  date = Date.new(options[:year], options[:month], day.to_i)
                  weekend = [0,6].include?(date.wday)
                  col_options[:class] << ' today' if today == date
                  col_options[:class] << ' weekend' if weekend
                  
                end
               day_letter = day_letter.succ if day != 1 && !weekend && !day.blank?
               day_letter = 'A' if day_letter == 'F'
                col_options[:class] << ' other' if day.blank?
                
                if block_given? && !day.blank?
                  if options[:events]
                    events = capture(date, records[date.to_s(:number)], &block)
                  else
                    events = capture(date, &block)
                  end
                  
                  col_options[:class] << ' events' unless events.blank?
                end
                cols << content_tag(:td, col_options) do
                  day = options[:today] if options[:today] && date == today
                  top = content_tag(:div,content_tag(:a, day, {:style=>'float:left;'}) + content_tag(:center, day_letter + content_tag(:a, nil, {:href=>'#checkbox', :class=>'fakecheck',:id=>'fakedotcom',:style=>'float:right'})),{:class =>'top'}) unless day.blank? || weekend
                  (top.nil?)? events : top + events
                end
              end
            end
          end
        
          caption + head + rows
        end
      
        concat(contents) if block_given?        
        
        contents
      end
    end
  end
end
