require "open-uri"

namespace :coursera do
  namespace :import do
    def build_url(resource, fields="", includes="")
      base_url = "https://api.coursera.org/api/catalog.v1"
      "#{base_url}/#{resource}?fields=#{fields}&includes=#{includes}"
    end

    def save_record(myclass, tuple)
      unless myclass.exists?(id: tuple["id"])
        puts "adding: #{tuple["id"]} #{tuple["name"]} #{tuple["fullName"]}"
        myinstance    = myclass.new(tuple.except!("links"))
        myinstance.id = tuple["id"]
        myinstance.save
      end
    end

    desc "Import all coursera resources and relationships"
    task :all => [:resources, :relationships]

    desc "Import all coursera resources"
    task :resources => [:courses, :sessions, :instructors, :universities, :categories]

    desc "Import all coursera relationships"
    task :relationships => [:courses_categories, :courses_universities, :instructor_relationships]

    desc "Import coursera courses." 
    task :courses => :environment do
      resource = "courses"
      fields   = "id,shortName,name,language,largeIcon,photo,previewLink,shortDescription,smallIcon,smallIconHover,subtitleLanguagesCsv,isTranslate,universityLogo,universityLogoSt,video,videoId,aboutTheCourse,targetAudience,faq,courseSyllabus,courseFormat,suggestedReadings,instructor,estimatedClassWorkload,aboutTheInstructor,recommendedBackground"
      # includes = "sessions,categories,instructors,universities"
      url = build_url(resource, fields)

      puts "Import courses #{url}"
      courses = open(url)
      json_response = JSON.parse(courses.read)

      json_response["elements"].each do |course|
        save_record CourseraCourse, course
      end
    end

    desc "Import coursera sessions." 
    task :sessions => :environment do
      resource = "sessions"
      fields = "id,courseId,homeLink,status,active,durationString,startDay,startMonth,startYear,name,signatureTrackCloseTime,signatureTrackOpenTime,signatureTrackPrice,signatureTrackRegularPrice,eligibleForCertificates,eligibleForSignatureTrack,certificateDescription,certificatesReady"
      # includes = "instructors,courses"
      url = build_url(resource, fields)
     
      puts "Import sessions #{url}"
      sessions = open(url)
      json_response = JSON.parse(sessions.read)

      json_response["elements"].each do |session|
        save_record CourseraSession, session
      end
    end

    desc "Import coursera instructors." 
    task :instructors => :environment do
      resource = "instructors"
      fields = "id,photo,photo150,bio,prefixName,firstName,middleName,lastName,suffixName,fullName,title,department,website,websiteTwitter,websiteFacebook,websiteLinkedin,websiteGplus,shortName"
      # includes = "universities,courses,sessions"
      url = build_url(resource, fields)

      puts "Import instructors #{url}"
      instructors = open(url)
      json_response = JSON.parse(instructors.read)

      json_response["elements"].each do |instructor|
        save_record CourseraInstructor, instructor
      end
    end

    desc "Import coursera universities." 
    task :universities => :environment do
      resource = "universities"
      fields = "id,name,shortName,description,banner,homeLink,location,locationCity,locationState,locationCountry,locationLat,locationLng,classLogo,website,websiteTwitter,websiteFacebook,websiteYoutube,logo,squareLogo,landingPageBanner"
      # includes = "courses,instructors"
      url = build_url(resource, fields)

      puts "Import universities #{url}"
      universities = open(url)
      json_response = JSON.parse(universities.read)

      json_response["elements"].each do |university|
        save_record CourseraUniversity, university
      end
    end

    desc "Import coursera categories." 
    task :categories => :environment do
      resource = "categories"
      fields = "id,name,shortName,description"
      url = build_url(resource, fields)

      puts "Import categories #{url}"
      categories = open(url)
      json_response = JSON.parse(categories.read)

      json_response["elements"].each do |category|
        save_record CourseraCategory, category
      end
    end

    desc "Import coursera courses-categories relationship"
    task :courses_categories => :environment do
      resource = "categories"
      fields = "id"
      includes = "courses"
      url = build_url(resource, fields, includes)

      puts "Import courses-categories #{url}"
      categories = open(url)
      json_response = JSON.parse(categories.read)

      total_courses = 0

      json_response["elements"].each do |category|
        c = CourseraCategory.find(category["id"])
        found = 0
        category["links"]["courses"].each do |course_id|
          if CourseraCourse.exists?(id: course_id)
            unless c.coursera_courses.include?(CourseraCourse.find(course_id))
              c.coursera_courses << CourseraCourse.find(course_id)
            end
            found += 1
          end
        end
        c.save
        miss = category["links"]["courses"].count - found
        total_courses += found
        puts "Found #{found} courses for category #{c.name}, missing #{miss} courses"
      end

      puts "Total courses: #{total_courses}"
    end

    desc "Import coursera courses-universities relationship"
    task :courses_universities => :environment do
      resource = "universities"
      fields = "id"
      includes = "courses"
      url = build_url(resource, fields, includes)

      puts "Import courses-universities #{url}"
      universities = open(url)
      json_response = JSON.parse(universities.read)

      total_courses = 0

      json_response["elements"].each do |university|
        c = CourseraUniversity.find(university["id"])
        found = 0
        course_ids = university["links"].fetch("courses",[])
        course_ids.each do |course_id|
          if CourseraCourse.exists?(id: course_id)
            unless c.coursera_courses.include?(CourseraCourse.find(course_id))
              c.coursera_courses << CourseraCourse.find(course_id)
            end
            found += 1
          end
        end
        c.save
        miss = course_ids.count - found
        total_courses += found
        puts "Found #{found} courses for university #{c.name}, missing #{miss} courses"
      end

      puts "Total courses: #{total_courses}"
    end

    desc "Import coursera instructor relationships with courses, sessions, universities"
    task :instructor_relationships => :environment do
      resource = "instructors"
      fields = "id"
      includes = "courses,sessions,universities"
      url = build_url(resource, fields, includes)

      puts "Import courses-instructors #{url}"
      instructors = open(url)
      json_response = JSON.parse(instructors.read)

      total_courses = 0
      total_sessions = 0
      total_universities = 0

      puts json_response["elements"][0]

      json_response["elements"].each do |instructor|
        begin
          i = CourseraInstructor.find(instructor["id"])
        rescue ActiveRecord::RecordNotFound => err
          puts err
          next
        end

        course_ids  = instructor["links"].fetch("courses",[])
        session_ids = instructor["links"].fetch("sessions",[])
        university_ids = instructor["links"].fetch("universities",[])

        found_courses = 0
        course_ids.each do |course_id|
          if CourseraCourse.exists?(id: course_id)
            unless i.coursera_courses.include?(CourseraCourse.find(course_id))
              i.coursera_courses << CourseraCourse.find(course_id)
            end
            found_courses += 1
          end
        end
        miss_courses = course_ids.count - found_courses
        total_courses += found_courses
        puts "Found #{found_courses} courses for instructor #{i.id}:#{i.firstName} #{i.lastName}, missing #{miss_courses} courses"
        
        found_sessions = 0
        session_ids.each do |session_id|
          if CourseraSession.exists?(id: session_id)
            unless i.coursera_sessions.include?(CourseraSession.find(session_id))
              i.coursera_sessions << CourseraSession.find(session_id)
            end
            found_sessions += 1
          end
        end
        miss_sessions = session_ids.count - found_sessions
        total_sessions += found_sessions
        puts "Found #{found_sessions} sessions for instructor #{i.id}:#{i.firstName} #{i.lastName}, missing #{miss_sessions} sessions"

        found_univeristies = 0
        university_ids.each do |university_id|
          if CourseraUniversity.exists?(id: university_id)
            unless i.coursera_universities.include?(CourseraUniversity.find(university_id))
              i.coursera_universities << CourseraUniversity.find(university_id)
            end
            found_univeristies += 1
          end
        end
        miss_universities = university_ids.count - found_univeristies
        total_universities += found_univeristies
        puts "Found #{found_univeristies} univeristies for instructor #{i.id}:#{i.firstName} #{i.lastName}, missing #{miss_universities} univeristies"

        i.save
        puts
      end

      puts "Total courses: #{total_courses}"
      puts "Total sessions: #{total_sessions}"
      puts "Total universities: #{total_universities}"
    end
  end
end