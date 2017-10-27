require 'selenium-cucumber'
require 'capybara/cucumber'

# Do Not Remove This File
# Add your custom steps here
#

require 'webdrivers'
require 'selenium-webdriver'

Before do |scenario|
  @url = {:domain => getSiteURL}
  Capybara.app_host = @url[:domain]
end

def getSiteURL
  site = ENV['SITE']
  stage = ENV['STAGE']
  case stage
  when 'dev', 'test', 'live', 'prod'
    url = $anyini[":#{site}"][":#{stage}"]
  else
    # invalid stage
    raise "invalid STAGE"
  end
  return url
end

def wait_for(seconds)
  # see http://elementalselenium.com/tips/47-waiting
  # sets maximum time to wait, not wait first, then do it
  Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
end

def check_image(type, type_path)
  # https://stackoverflow.com/questions/10109680/how-to-test-if-an-img-tag-points-to-an-existing-image
  # you can't actually check response codes in Capybara, though it works for :poltergeist
  # Capybara::NotSupportedByDriverError for :chrome :selenium_chrome_headless
  img = find(type, type_path)
  if Capybara.current_driver == :poltergeist
    visit img[:src]
    #expect(page).not_to have_content('Not Found')
    expect(page.status_code).to be(200)
  else
    puts 'check_image unsupported on this driver'
  end
end

def sleep_for(sec)
  sleep sec.to_i
end

def click_js(link_text)
  js = "var link = document.evaluate('//a[contains(.,'" + link_text + "')], document, null, XPathResult.ANY_TYPE, null ); link.click();"
  what_is(js)
  page.execute_script(js)
end

def get_href(xpath)
  what_is(xpath)
  href = page.first(:xpath, xpath, visible: false)[:href]
end

#*******************************************************************************************
#*******************************************************************************************

#*******************************************************************************************
#*******************************************************************************************

Given("I show the running environment") do
  puts "Hostname: " + Socket.gethostname
  puts "Current driver: " + Capybara.current_driver.inspect
  puts "Javascript driver: " + Capybara.javascript_driver.inspect
  puts "Current stage: " + ENV['STAGE']
  puts "Current platform: " + $platform
end


Given("I am testing the correct domain") do
  puts "Domain: #{@url[:domain]}"
end

Given("I go to the home page") do
  wait_for(300) {
    visit(@url[:domain])
  }
end

Then /^I go to page "(.*?)"$/ do |sitepage|
  wait_for(20) {
    target = "#{@url[:domain]}" + "/#{sitepage}"
    visit "#{target}"
  }
end

Then("I click on the {string} link") do |string|
 wait_for(300) {
  #expect(page).to have_link('', text: string)
  click_link(string)
  }
end

Then("I click on the {string} library link") do |string|
  - warning: string has commas in it for some reason
  # commas went away when I reomved the single quote from the feature call
  # '<library>' -> <library>
 wait_for(10) {
  # these links are hidden to poltergeist
  # https://github.com/thoughtbot/capybara-webkit/issues/494
  xpath = %q{//a[text()='#{string}']}
  page = get_href(xpath);
  visit page
  # element = page.find(:xpath,"//a/h2[text()='#{string}']", visible: false)
  # page.driver.browser.execute_script("arguments[0].click()", element.native)
  # element.click
  # what_is(element)
  # within (page.find(:xpath,"//a/h2[text()='#{string}']").find(:xpath, '../../..')) {
  #   element = find(:xpath, "//a/h2", visible: false)
  #   page.driver.browser.execute_script("arguments[0].click()", element.native)
  # }
  }
end

Then("I should see the CUWebLogin dialog") do
  wait_for(5) {
    find(:css, '.input-submit')
  }
  expect(page.title).to eq('Cornell University Web Login')
end

Then /^show me the page$/ do
  wait_for(300) {
    print page.html
    puts "current url:"
    puts URI.parse(current_url)
  }
end

Then /^show me the page after sleeping "(.*?)"$/ do |seconds|
  sleep_for(seconds)
  print page.html
  puts "current url:"
  puts URI.parse(current_url)
end

Then /^the page should show content "(.*?)"$/ do |expectedText|
  expect(page).to have_content(expectedText)
end

Then /^I search ares for "(.*?)"$/ do |searchstring|
  fill_in 'search_box', with: searchstring
  page.find('#edit-submit').click
end

Then /^I visit page "(.*?)"$/ do |sitepage|
  target = "#{@url[:domain]}" + "/#{sitepage}"
  visit target
end

Then("I enter {string} in the ares search") do |string|
  page.find_by_id('search_box').send_keys string
end

Then("I select the first option from the ares popup") do
  wait_for(5) {
    page.find('.dropdown-menu > li:nth-child(1) > a:nth-child(1)')
  }
  page.find('.dropdown-menu > li:nth-child(1) > a:nth-child(1)').click
end

Then("the ares results should contain {string}") do |string|
  wait_for(500) {
    expect(page.find(:xpath, 'id(\'course-reserves-all-inline\')')).to have_content(string)
  }
end

Then("the page title should start with {string}") do |string|
  wait_for(60) {
    print page.html
    expect(page.title).to start_with(string)
  }
end

When("I wait for the ares spinner to stop") do
  # see https://groups.google.com/d/msg/ruby-capybara/Mz7txv1Sm0U/xBypglg-1roJ
  wait_for(300) {
    expect(page).not_to have_selector('#items-spinner-all-inline', visible: true)
  }
end

When("I search the catalog for {string}") do |string|
#  page.fill_in 'q', with: string
 page.find(:id, 'q').send_keys(string)
  # fill_in_autocomplete('q', string)
end

Then("the catalog search should suggest {string}") do |string|
  pending # can't figure out how to do this
  wait_for (10) {
    find('ul.ui-autocomplete').should have_content(string)
  }
end

When("I check the catalog autocomplete for {string}") do |string|
  pending # can't figure out how to do this
  wait_for (10) {
   # expect(page).not_to have_selector('ul.ui-autocomplete', :visible => false)
    fill_in_autocomplete('q', string)
    # expect(page).to have_selector('ul.ui-autocomplete', :visible => false)
  }
end

Then("I should see the hours listing for {string} with {string}") do |string, string2|
  wait_for(5) {
    within(page.find(:xpath,"//a/h2[text()='#{string}']").find(:xpath, '../../..')) {
      if string2 == true
        expect(find(".today-hours").text).not_to be_empty
      end
      check_image(:css, '.library-thumbnail img')
    }
  }
end

Then("I should see the table of {string} hours") do |string|
  pending # Write code here that turns the phrase above into concrete actions
  expect(page.find(:xpath, "//table/caption")).to have_content('Display of Opening hours')
  expect(page.find(:xpath, "//td[8]/span")).not_to be_empty
  expect(page.find(:css, "td.s-lc-wh-locname")).to have_content(string)
end
