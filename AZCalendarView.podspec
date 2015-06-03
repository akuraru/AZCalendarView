Pod::Spec.new do |s|
  s.name         = "AZCalendarView"
  s.version      = "1.0.0"
  s.summary      = "iOS CalendarView library - has similar delegate methods to a UITableViewDataSource."
  s.homepage     = "http://efcl.info/"
  s.ios.deployment_target = '7.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "azu" => "azuciao@gmail.com" }
  s.source       = {
    :git => "https://github.com/azu/AZCalendarView.git",
    :tag => s.version.to_s 
  }
  s.requires_arc = true
  s.platform     = :ios, '7.0'
  s.source_files = 'AZCalendarView/AZCalendar/{Core,Models}/*.{h,m}'
end
