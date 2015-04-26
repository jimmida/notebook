# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150426073318) do

  create_table "coursera_categories", id: false, force: true do |t|
    t.integer  "id",          null: false
    t.string   "name"
    t.string   "shortName"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coursera_categories", ["id"], name: "index_coursera_categories_on_id", unique: true

  create_table "coursera_categories_courses", id: false, force: true do |t|
    t.integer "coursera_course_id",   null: false
    t.integer "coursera_category_id", null: false
  end

  add_index "coursera_categories_courses", ["coursera_category_id", "coursera_course_id"], name: "coursera_category_course", unique: true
  add_index "coursera_categories_courses", ["coursera_course_id", "coursera_category_id"], name: "coursera_course_category", unique: true

  create_table "coursera_courses", id: false, force: true do |t|
    t.integer  "id",                     null: false
    t.string   "shortName"
    t.string   "name"
    t.string   "language"
    t.string   "largeIcon"
    t.string   "photo"
    t.string   "previewLink"
    t.string   "shortDescription"
    t.string   "smallIcon"
    t.string   "smallIconHover"
    t.string   "subtitleLanguagesCsv"
    t.boolean  "isTranslate"
    t.string   "universityLogo"
    t.string   "universityLogoSt"
    t.string   "video"
    t.string   "videoId"
    t.string   "aboutTheCourse"
    t.string   "targetAudience"
    t.string   "faq"
    t.string   "courseSyllabus"
    t.string   "courseFormat"
    t.string   "suggestedReadings"
    t.string   "instructor"
    t.string   "estimatedClassWorkload"
    t.string   "aboutTheInstructor"
    t.string   "recommendedBackground"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coursera_courses", ["id"], name: "index_coursera_courses_on_id", unique: true

  create_table "coursera_courses_instructors", id: false, force: true do |t|
    t.integer "coursera_course_id",     null: false
    t.integer "coursera_instructor_id", null: false
  end

  add_index "coursera_courses_instructors", ["coursera_course_id", "coursera_instructor_id"], name: "coursera_course_instructor", unique: true
  add_index "coursera_courses_instructors", ["coursera_instructor_id", "coursera_course_id"], name: "coursera_instructor_course", unique: true

  create_table "coursera_courses_universities", id: false, force: true do |t|
    t.integer "coursera_course_id",     null: false
    t.integer "coursera_university_id", null: false
  end

  add_index "coursera_courses_universities", ["coursera_course_id", "coursera_university_id"], name: "coursera_course_university", unique: true
  add_index "coursera_courses_universities", ["coursera_university_id", "coursera_course_id"], name: "coursera_university_course", unique: true

  create_table "coursera_instructors", id: false, force: true do |t|
    t.integer  "id",              null: false
    t.string   "photo"
    t.string   "photo150"
    t.string   "bio"
    t.string   "prefixName"
    t.string   "firstName"
    t.string   "middleName"
    t.string   "lastName"
    t.string   "suffixName"
    t.string   "fullName"
    t.string   "title"
    t.string   "department"
    t.string   "website"
    t.string   "websiteTwitter"
    t.string   "websiteFacebook"
    t.string   "websiteLinkedin"
    t.string   "websiteGplus"
    t.string   "shortName"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coursera_instructors", ["id"], name: "index_coursera_instructors_on_id", unique: true

  create_table "coursera_instructors_sessions", id: false, force: true do |t|
    t.integer "coursera_instructor_id", null: false
    t.integer "coursera_session_id",    null: false
  end

  add_index "coursera_instructors_sessions", ["coursera_instructor_id", "coursera_session_id"], name: "coursera_instructor_session", unique: true
  add_index "coursera_instructors_sessions", ["coursera_session_id", "coursera_instructor_id"], name: "coursera_session_instructor", unique: true

  create_table "coursera_instructors_universities", id: false, force: true do |t|
    t.integer "coursera_instructor_id", null: false
    t.integer "coursera_university_id", null: false
  end

  add_index "coursera_instructors_universities", ["coursera_instructor_id", "coursera_university_id"], name: "coursera_instructor_university", unique: true
  add_index "coursera_instructors_universities", ["coursera_university_id", "coursera_instructor_id"], name: "coursera_university_instructor", unique: true

  create_table "coursera_sessions", id: false, force: true do |t|
    t.integer  "id",                         null: false
    t.integer  "courseId"
    t.string   "homeLink"
    t.integer  "status"
    t.boolean  "active"
    t.string   "durationString"
    t.integer  "startDay"
    t.integer  "startMonth"
    t.integer  "startYear"
    t.string   "name"
    t.datetime "signatureTrackCloseTime"
    t.datetime "signatureTrackOpenTime"
    t.float    "signatureTrackPrice"
    t.float    "signatureTrackRegularPrice"
    t.boolean  "eligibleForCertificates"
    t.boolean  "eligibleForSignatureTrack"
    t.string   "certificateDescription"
    t.boolean  "certificatesReady"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coursera_sessions", ["id"], name: "index_coursera_sessions_on_id", unique: true

  create_table "coursera_universities", id: false, force: true do |t|
    t.integer  "id",                null: false
    t.string   "name"
    t.string   "shortName"
    t.string   "description"
    t.string   "banner"
    t.string   "homeLink"
    t.string   "location"
    t.string   "locationCity"
    t.string   "locationState"
    t.string   "locationCountry"
    t.decimal  "locationLat"
    t.decimal  "locationLng"
    t.string   "classLogo"
    t.string   "website"
    t.string   "websiteTwitter"
    t.string   "websiteFacebook"
    t.string   "websiteYoutube"
    t.string   "logo"
    t.string   "squareLogo"
    t.string   "landingPageBanner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coursera_universities", ["id"], name: "index_coursera_universities_on_id", unique: true

end
