Pod::Spec.new do |s|
  s.name         = "AZCalendarView"
  s.version      = "0.1.1"
  s.summary      = "iOS CalendarView library - has similar delegate methods to a UITableViewDataSource."
  s.homepage     = "http://efcl.info/"
  s.license      = 'MIT'
  s.author       = { "azu" => "azuciao@gmail.com" }
  s.source       = {
    :git => "https://github.com/azu/AZCalendarView.git",
    :tag => s.version.to_s 
  }
  s.requires_arc = true
  s.platform     = :ios
  s.source_files = 'AZCalendarView/AZCalendar/{Core,Models}/*.{h,m}'
end
