#---------------------------------
# Models
#---------------------------------
rails g model CourseraCourse \
    id:integer:uniq:index \
    shortName:string \
    name:string \
    language:string \
    largeIcon:string \
    photo:string \
    previewLink:string \
    shortDescription:string \
    smallIcon:string \
    smallIconHover:string \
    subtitleLanguagesCsv:string \
    isTranslate:boolean \
    universityLogo:string \
    universityLogoSt:string \
    video:string \
    videoId:string \
    aboutTheCourse:string \
    targetAudience:string \
    faq:string \
    courseSyllabus:string \
    courseFormat:string \
    suggestedReadings:string \
    instructor:string \
    estimatedClassWorkload:string \
    aboutTheInstructor:string \
    recommendedBackground:string

rails g model CourseraSession \
    id:integer:uniq:index \
    courseId:integer \
    homeLink:string \
    status:integer \
    active:boolean \
    durationstring:string \
    startDay:integer \
    startMonth:integer \
    startYear:integer \
    name:string \
    signatureTrackCloseTime:datetime \
    signatureTrackOpenTime:datetime \
    signatureTrackPrice:double \
    signatureTrackRegularPrice:float \
    eligibleForCertificates:boolean \
    eligibleForSignatureTrack:boolean \
    certificateDescription:string \
    certificatesReady:boolean

rails g model CourseraInstructor \
    id:integer:uniq:index \
    photo:string \
    photo150:string \
    bio:string \
    prefixName:string \
    firstName:string \
    middleName:string \
    lastName:string \
    suffixName:string \
    fullName:string \
    title:string \
    department:string \
    website:string \
    websiteTwitter:string \
    websiteFacebook:string \
    websiteLinkedin:string \
    websiteGplus:string \
    shortName:string

rails g model CourseraUniversity \
    id:integer:uniq:index \
    name:String \
    shortName:String \
    description:String \
    banner:String \
    homeLink:String \
    location:String \
    locationCity:String \
    locationState:String \
    locationCountry:String \
    locationLat:Double \
    locationLng:Double \
    classLogo:String \
    website:String \
    websiteTwitter:String \
    websiteFacebook:String \
    websiteYoutube:String \
    logo:String \
    squareLogo:String \
    landingPageBanner:String

rails g model CourseraCategory \
    id:integer:uniq:index \
    name:String \
    shortName:String \
    description:String

#---------------------------------
# Many-to-many Relationships
#---------------------------------
rails g migration CreateJoinTableCourseraCourseCategory coursera_course coursera_category

rails g migration CreateJoinTableCourseraCourseInstructor coursera_course coursera_instructor

rails g migration CreateJoinTableCourseraInstructorSession coursera_instructor coursera_session

rails g migration CreateJoinTableCourseraInstructorUniveristy coursera_instructor coursera_university

rails g migration CreateJoinTableCourseraCourseUniversity coursera_course coursera_university

#---------------------------------
# Notebook Models
#---------------------------------
rails g scaffold Course name:string description:string url:string

rails g scaffold Lesson course:reference name:string url:string

rails g model Note course:references lesson:references content:text


