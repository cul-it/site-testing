require 'rubygems'
require 'selenium-cucumber'
require 'rspec/expectations'
require 'capybara/poltergeist'
require 'inifile'

Before do |scenario|
  @anyini = IniFile.load('site-testing.ini')
  @url = {:domain => getSiteURL}
end

def getSiteURL
  site = ENV['SITE']
  stage = ENV['STAGE']
  case stage
  when 'dev', 'test', 'live', 'prod'
    url = @anyini[":#{site}"][":#{stage}"]
  else
    # invalid stage
    raise "invalid STAGE"
  end
  return url
end


# Store command line arguments
$browser_type = ENV['BROWSER'] || 'chrome'
$platform = ENV['PLATFORM'] || 'desktop'
$os_version = ENV['OS_VERSION']
$device_name = ENV['DEVICE_NAME']
$udid = ENV['UDID']
$app_path = ENV['APP_PATH']

# check for valid parameters
validate_parameters $platform, $browser_type, $app_path

# If platform is android or ios create driver instance for mobile browser
if $platform == 'android' or $platform == 'iOS'

  if $browser_type == 'native'
    $browser_type = "Browser"
  end

  if $platform == 'android'
    $device_name, $os_version = get_device_info
  end

  desired_caps = {
    caps:       {
      platformName:  $platform,
      browserName: $browser_type,
      versionNumber: $os_version,
      deviceName: $device_name,
      udid: $udid,
      app: ".//#{$app_path}"
      },
    }

  begin
    $driver = Appium::Driver.new(desired_caps).start_driver
  rescue Exception => e
    puts e.message
    Process.exit(0)
  end
else # else create driver instance for desktop browser
  begin
    case ENV['HEADLESS']
    when "poltergeist"
      # headless tests with poltergeist/PhantomJS
      options = {js_errors: false, window_size: [1280, 1024], debug: false}
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, options)
      end
      Capybara.default_driver    = :poltergeist
      Capybara.javascript_driver = :poltergeist
    when "selenium_chrome_headless"
      Capybara.register_driver :selenium_chrome_headless do |app|
        browser_options = ::Selenium::WebDriver::Chrome::Options.new()
        browser_options.args << '--headless'
        browser_options.args << '--disable-gpu'
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
      end
      Capybara.default_driver    = :selenium_chrome_headless
      Capybara.javascript_driver = :headless_chrome
    when "headless_chrome"
      Capybara.register_driver :headless_chrome do |app|
        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: %w(headless disable-gpu) })
        Capybara::Selenium::Driver.new app,
          browser: :chrome,
          desired_capabilities: capabilities
      end
      Capybara.default_driver    = :headless_chrome
      Capybara.javascript_driver = :headless_chrome
    when nil
      Capybara.register_driver :chrome do |app|
        Capybara::Selenium::Driver.new(app, browser: :chrome)
      end
      Capybara.default_driver    = :chrome
      Capybara.javascript_driver = :headless_chrome
    else
      $driver = Selenium::WebDriver.for(:"#{$browser_type}")
      $driver.manage().window().maximize()
    end
  rescue Exception => e
    puts e.message
    Process.exit(0)
  end
end
