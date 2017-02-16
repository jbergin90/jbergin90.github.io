require 'yaml'
# require 'json'
require 'pp'

input_file = File.read("./yamlresume.yml")
@input_yaml = YAML.load(input_file)

@output_file = File.new("./index.html", "w+")

# pp(@input_yaml)
# @output_file.puts JSON.generate(input_yaml)

# GENERATE THE INFO
has_basics = @input_yaml.has_key? "basics"
if has_basics
  @basics_hash = @input_yaml["basics"]
  # @output_file.puts "#{has_basics}"
  # @output_file.puts "#{@basics_hash}"
end

# Name
@name = nil
has_first_name = @basics_hash.has_key? "first_name"
has_middle_name = @basics_hash.has_key? "middle_name"
has_last_name = @basics_hash.has_key? "last_name"

if (has_first_name || has_middle_name || has_last_name)
  @name = ""

  if has_first_name
    @name = @name + " #{@basics_hash["first_name"]}"
  end

  if has_middle_name
    @name = @name + " #{@basics_hash["middle_name"]}"
  end

  if has_last_name
    @name = @name + " #{@basics_hash["last_name"]}"
  end

# Remove all leading and trailing whitespace
  @name = @name.strip()
  # @output_file.puts "#{@name}"
end

# email
@email = nil
has_email = @basics_hash["email"]
if(has_email)
  @email = @basics_hash["email"]
end

# email
@has_email = @basics_hash.has_key? "email"

# phone
@has_phone = (@basics_hash.has_key? "phone")
if @has_phone
  @has_phone = (@basics_hash["phone"].has_key? "name") && (@basics_hash["phone"].has_key? "url")
end

# website
@has_website = (@basics_hash.has_key? "website")
if @has_website
  @has_website = (@basics_hash["website"].has_key? "name") && (@basics_hash["website"].has_key? "url")
end

# GENERATE THE RESUME
# fileHtml = File.new("resume.html", "w+")

def generate_skills
  # This is where it gets complicated. We want to iterate through the string
  if @input_yaml.has_key? "skills"
    skills_array = @input_yaml["skills"]
    if (!(skills_array.empty?))
      @output_file.puts "<section>"
  		@output_file.puts "<div class=\"sectionTitle\">"
  		@output_file.puts "<h1>Skills</h1>"
  		@output_file.puts "</div>"
      @output_file.puts "<div class=\"sectionContent\">"
      # iterate through array
      skills_array.each do |i|
        if(i.has_key? "name")
          @output_file.puts "<article>"
          @output_file.puts "<h2>#{i["name"]}</h2>"

          if(i.has_key? "keywords")
            if(!(i["keywords"].empty?))
              @output_file.puts "<ul class=\"keySkills\">"
              i["keywords"].each do |j|
                @output_file.puts "<li>#{j}</li>"
              end
              @output_file.puts "</ul>"
            end
          end

          @output_file.puts "</article>"
        end
      end
      @output_file.puts "</div>"
      @output_file.puts "<div class=\"clear\"></div>"
      @output_file.puts "</section>"
    end
  end
end

def generate_education
# This is where it gets complicated. We want to iterate through the string
if @input_yaml.has_key? "education"
  education_array = @input_yaml["education"]
  if (!(education_array.empty?))
    @output_file.puts "<section>"
		@output_file.puts "<div class=\"sectionTitle\">"
		@output_file.puts "<h1>Education</h1>"
		@output_file.puts "</div>"
    @output_file.puts "<div class=\"sectionContent\">"
    # iterate through array
    education_array.each do |i|
      if(i.has_key? "institution")
        @output_file.puts "<article>"
        @output_file.puts "<h2>#{i["institution"]}<br>#{i["studyType"]}</h2>"

        # Area
        if(i.has_key? "area")
          @output_file.puts "<p class=\"subDetails\">#{i["area"]}</p>"
        end

        # Location


        # Website
        if(i.has_key? "website")
          if(i["website"].has_key? "url") && (i["website"].has_key? "name")
            @output_file.puts "<p class=\"subDetails\"><a href=\"#{i["website"]["url"]}\">#{i["website"]["name"]}</a></p>"
          end
        end

        # Date
        if(i.has_key? "startDate")
          start_date = Date.parse(i["startDate"])
          date = "#{start_date.strftime('%b %Y')} - "
          if(i.has_key? "endDate")
            end_date = Date.parse(i["endDate"])
            date = date + "#{end_date.strftime('%b %Y')}"
          else
            date = date + "Present"
          end
          @output_file.puts "<p class=\"subDetails\">#{date}</p>"
        end

        # Summary
        if(i.has_key? "summary")
          @output_file.puts "<p>#{i["summary"]}</p>"
        end

        # highlights
        if i.has_key? "highlights"
          if (!(i["highlights"].empty?))
            @output_file.puts "<ul>"
            i["highlights"].each do |j|
              if(j.has_key? "summary")
                @output_file.puts "<li>#{j["summary"]}</li>"
              end
            end
            @output_file.puts "</ul>"
          end
        end

        @output_file.puts "</article>"
      end
    end
    @output_file.puts "</div>"
    @output_file.puts "<div class=\"clear\"></div>"
    @output_file.puts "</section>"
  end
end
end

def generate_experience
# This is where it gets complicated. We want to iterate through the string
if @input_yaml.has_key? "work"
  work_array = @input_yaml["work"]
  if (!(work_array.empty?))
    @output_file.puts "<section>"
		@output_file.puts "<div class=\"sectionTitle\">"
		@output_file.puts "<h1>Experience</h1>"
		@output_file.puts "</div>"
    @output_file.puts "<div class=\"sectionContent\">"
    # iterate through array
    work_array.each do |i|
      if(i.has_key? "position") && (i.has_key? "company")
        @output_file.puts "<article>"
        @output_file.puts "<h2>#{i["position"]}<br>#{i["company"]}</h2>"

        # Location


        # Website
        if(i.has_key? "website")
          if(i["website"].has_key? "url") && (i["website"].has_key? "name")
            @output_file.puts "<p class=\"subDetails\"><a href=\"#{i["website"]["url"]}\">#{i["website"]["name"]}</a></p>"
          end
        end

        # Date
        if(i.has_key? "startDate")
          start_date = Date.parse(i["startDate"])
          date = "#{start_date.strftime('%b %Y')} - "
          if(i.has_key? "endDate")
            end_date = Date.parse(i["endDate"])
            elapsed_time = Date.new(0) + (end_date - start_date);
            elapsed_time_string = "("
            if(elapsed_time.year > 1)
              elapsed_time_string = elapsed_time_string + "#{elapsed_time.strftime('%_Y')} years"
            elsif (elapsed_time.year > 0)
              elapsed_time_string = elapsed_time_string + "#{elapsed_time.strftime('%_Y')} year"
            end

            if(elapsed_time.year > 0) && (elapsed_time.month > 0)
              elapsed_time_string = elapsed_time_string + " and "
            end

            if(elapsed_time.month > 1)
              elapsed_time_string = elapsed_time_string + "#{elapsed_time.strftime('%-m')} months"
            elsif (elapsed_time.month > 0)
              elapsed_time_string = elapsed_time_string + "#{elapsed_time.strftime('%-m')} month"
            end

            elapsed_time_string = elapsed_time_string + ")"
            date = date + "#{end_date.strftime('%b %Y')}" + " " + elapsed_time_string
          else
            date = date + "Present"
          end
          @output_file.puts "<p class=\"subDetails\">#{date}</p>"
        end

        # Summary
        if(i.has_key? "company_summary")
          @output_file.puts "<p>#{i["company_summary"]}</p>"
        end

        # highlights
        if i.has_key? "highlights"
          if (!(i["highlights"].empty?))
            @output_file.puts "<ul>"
            i["highlights"].each do |j|
              if(j.has_key? "summary")
                @output_file.puts "<li>#{j["summary"]}</li>"
              end
            end
            @output_file.puts "</ul>"
          end
        end

        @output_file.puts "</article>"
      end
    end
    @output_file.puts "</div>"
    @output_file.puts "<div class=\"clear\"></div>"
    @output_file.puts "</section>"
  end
end
end

def generate_summary
  has_summary = @basics_hash.has_key? "summary"

  if has_summary
    @output_file.puts "<section>"
		@output_file.puts "<div class=\"sectionTitle\">"
		@output_file.puts "<h1>Summary</h1>"
		@output_file.puts "</div>"

		@output_file.puts "<div class=\"sectionContent\">"
		@output_file.puts "<p>#{@basics_hash["summary"]}</p>"
		@output_file.puts "</div>"
		@output_file.puts "<div class=\"clear\"></div>"
		@output_file.puts "</section>"
  end
end

def generate_main
  @output_file.puts "<div id=\"mainArea\" class=\"quickFade delayFive\">"

  generate_summary()
  generate_experience()
  generate_education()
  generate_skills()

  @output_file.puts "</div>"
end

def generate_email
  @output_file.puts "<li>e: <a href=\"mailto:#{@basics_hash["email"]}\" target=\"_blank\">#{@basics_hash["email"]}</a></li>"
end

def generate_website
  @output_file.puts "<li>w: <a href=\"#{@basics_hash["website"]["url"]}\">#{@basics_hash["website"]["name"]}</a></li>"
end

def generate_phone
  @output_file.puts "<li>c: <a href=\"#{@basics_hash["phone"]["url"]}\">#{@basics_hash["phone"]["name"]}</a></li>"
end

def generate_contact_details
  if(@has_email || @has_phone || @has_website)
    @output_file.puts "<div id=\"contactDetails\" class=\"quickFade delayFour\">"
    @output_file.puts "<ul>"
    generate_email()
    generate_website()
    generate_phone()
    @output_file.puts "</ul>"
    @output_file.puts "</div>"
  end
end

def generate_picture
  if (@basics_hash.has_key? "picture")
    @output_file.puts "<div id=\"headshot\" class=\"quickFade\">"
    # TODO: Change James Bergin to name.
    @output_file.puts "<img src=\"#{@basics_hash["picture"]}\" alt=\"James Bergin\" />"
    @output_file.puts "</div>"
  end
end

def generate_name_role
  if (@name != nil) && (@basics_hash.has_key? "role")
    @output_file.puts "<div id=\"name\">"
    @output_file.puts "<h1 class=\"quickFade delayTwo\">#{@name}</h1>"
    @output_file.puts "<h2 class=\"quickFade delayThree\">#{@basics_hash["role"]}</h2>"
    @output_file.puts "</div>"
  end
end

def generate_header
@output_file.puts "<div class=\"mainDetails\">"

generate_picture()
generate_name_role()
generate_contact_details()

@output_file.puts "<div class=\"clear\"></div>"

@output_file.puts "</div>"
end

def generate_cv
@output_file.puts "<div id=\"cv\" class=\"instaFade\">"

generate_header()
generate_main()

@output_file.puts "</div>"
end

def generate_body
@output_file.puts "---"
@output_file.puts "layout: resumepage"
@output_file.puts "---"
@output_file.puts "<body id=\"top\">"

generate_cv()

@output_file.puts "</body>"
end

generate_body()
