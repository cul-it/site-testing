# filename: chrome.rb

require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

def setup
  Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd, 'chromedriver')
  @driver = Selenium::WebDriver.for :chrome
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end