require 'selenium-cucumber'
require 'capybara/cucumber'
require 'spreewald/web_steps'

# Do Not Remove This File
# Add your custom steps here
#

require 'webdrivers'
require 'selenium-webdriver'

require 'show_me_the_cookies'
World(ShowMeTheCookies)

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
  when 'ares'
    if site == 'music.library.cornell.edu'
      url = $anyini[":#{site}"][":#{stage}"]
    else
      raise "invalid STAGE for this site"
    end
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
  sleep(sec.to_f)
end

def pause_for_user_input(message)
  $stderr.write message
  $stderr.write "\nPress enter to continue\n"
  $stdin.gets
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

def getTestMark(*args)
  hasher = Digest::MD5.new
  hasher << 'Cornell University Library IT Testing'
  args.each { |arg| hasher << arg }
  return hasher.hexdigest
end

def take_screenshot_with_file_name(file_name, message)
  page.save_screenshot("#{file_name}.png", :full => true)
end

#*******************************************************************************************
#*******************************************************************************************

#*******************************************************************************************
#*******************************************************************************************

Then("I take a screen shot with file name {string}") do |string|
  take_screenshot_with_file_name(string, "ScreenShot")
end

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

Given("I am testing domain {string}") do |string|
  expect(string).to be == "#{@url[:domain]}"
end

Given("I go to the home page") do
  visit @url[:domain]
end

# Then /^I go to page "(.*?)"$/ do |sitepage|
#   wait_for(20) {
#     target = "#{@url[:domain]}" + "/#{sitepage}"
#     visit "#{target}"
#   }
# end

Then("I click on the {string} link") do |string|
  wait_for(300) {
   #expect(page).to have_link('', text: string)
   click_link(string)
   }
end

Then("I click on the first {string} link") do |string|
  wait_for(300) {
    item = page.first('a', text: /#{string}?/i)
    item.click()
   }
end

Then("I click on the {string} menu item") do |string|
patiently do
  first('.menu').click_link(string)
  end
end

Then /^I click on the "(.*?)" library link$/ do |string|
  patiently do
    page.find(:xpath,"//a/h2[text()='#{string}']").click
  end
  # - warning: string has commas in it for some reason
  # commas went away when I reomved the single quote from the feature call
  # '<library>' -> <library>
 #wait_for(10) {
  # these links are hidden to poltergeist
  # https://github.com/thoughtbot/capybara-webkit/issues/494
  #xpath = %q{//a[text()='#{string}']}
  #page = get_href(xpath);
  #visit page
  # element = page.find(:xpath,"//a/h2[text()='#{string}']", visible: false)
  # page.driver.browser.execute_script("arguments[0].click()", element.native)
  # element.click
  # what_is(element)
  # within (page.find(:xpath,"//a/h2[text()='#{string}']").find(:xpath, '../../..')) {
  #   element = find(:xpath, "//a/h2", visible: false)
  #   page.driver.browser.execute_script("arguments[0].click()", element.native)
  # }
  #}
end

Then("I should see the CUWebLogin dialog") do
  wait_for(5) {
    find(:css, '.input-submit')
  }
  expect(page.title).to eq('Cornell University Web Login')
end

Then("I should see the Two-Step Login dialog") do
  wait_for(5) {
    find(:css, 'form#duo_form')
  }
  expect(page.find(:css, "#identity h1")).to have_content('Two-Step Login')
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
  patiently do
    expect(page.find_by_id('course-reserves-all-inline', :visible => :any)).to have_content(string)
    end
end

Then("I select the first option from the d8_ares popup") do
  wait_for(5) {
    page.find('#edit-course-select').find(:xpath, 'option[1]').select_option
  }
end

Given("I select option {int} from the d8_ares popup") do |int|
  wait_for(5) {
    page.find('#edit-course-select').find(:xpath, "option[#{int}]").select_option
  }
end

Then("I wait for the d8_ares results to load") do
  sleep_for(6)
  wait_for(300) {
    expect(page).not_to have_content('Loading reserve list ...')
  }
end

Then("the d8_ares results should show at least one title") do
  wait_for(10) {
    page.first('p.title')
  }
end

Then("show me the d8_ares results") do
  what_is(page.find_by_id('reserve-list'))
end

Then("show me the ares results") do
  patiently do
    what_is(page.find_by_id('course-reserves-all-inline'))
  end
end


Given("I select course {string} from the d8_ares popup") do |string|
  wait_for(5) {
    page.find('#edit-course-select').find('option', text: /#{string}?/i).select_option
  }
end

Then("the d8_ares results should show {string}") do |string|
  wait_for(10) {
    page.first('td.ares-title p strong', text: /#{string}?/i)
  }
end

Then("the page title should start with {string}") do |string|
  wait_for(60) {
    expect(page.title).to start_with(string)
  }
end

Then("the page should contain headline {string}") do |string|
  patiently do
    expect(page.first(:xpath, "//h1[text()='#{string}']"))
  end
end

When("I wait for the ares spinner to stop") do
  # see https://groups.google.com/d/msg/ruby-capybara/Mz7txv1Sm0U/xBypglg-1roJ
  patiently do
    expect(page).not_to have_selector('#items-spinner-all-inline', visible: true)
  end
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
  patiently do
    within(page.find(:xpath,"//a/h2[text()='#{string}']").find(:xpath, '../../..')) {
      if string2 == true
        expect(find(".today-hours").text).not_to be_empty
      end
      #check_image(:css, '.library-thumbnail img')
    }
  end
end

Given("I should see {string} library is closed") do |string|
  patiently do
    within(page.find(:xpath,"//a/h2[text()='#{string}']").find(:xpath, '../../..')) {
      expect(find("span.library-closed")).to have_content("Closed")
    }
  end
end

Then("I should see the closed lozenge") do
  expect(page.find("span.library-closed")).to have_content("Closed")
end

Given("I should see {string} library has a {string} link") do |string, string2|
  patiently do
    within(page.find(:xpath,"//a/h2[text()='#{string}']").find(:xpath, '../../..')) {
      expect(find("div.today-hours")).to have_link(string2)
    }
  end
end

Then("I should see a {string} link") do |string|
  expect(page).to have_link(string)
end

Then("I should see the {string} LibCal hours table") do | string |
  expect(page.find("table.s-lc-whw")).to have_content(string)
end

Then("I should see the table of {string} hours with row {string}") do |string, string2|
  case string2
  when 'false'
    # do nothing
  when 'library'
    patiently do
      expect(page.first(:xpath, "//td[text()='#{string}']")).to have_content(string)
    end
  when 'library-link'
    patiently do
      expect(page.first(:xpath, "//td/a[text()='#{string}']")).to have_content(string)
    end
  else
    patiently do
      expect(page.first(:xpath, "//td[text()='#{string2}']")).to have_content(string2)
    end
  end
end


Then("I test") do
  # /html/body/div[3]/div/div[2]/div/section[2]/div/div[2]/div/div[1]
  # /html/body/div[3]/div/div[2]/div/section[2]/div/div[2]/div/div[1]/span/div/div[2]/a/h2
  string = 'Africana Library'
  xpath = '//a' # works
  xpath = "//a/h2[text()='#{string}']" #nope
  xpath = "//a[text()='#{string}']" #yes
  xpath = "/html/body/div[3]/div/div[2]/div/section[2]/div/div[2]/div/div[1]"
  xpath = "/html/body/div[3]/div/div[2]/div/section[2]/div/div[2]/div/div[1]/span/div/div[2]/a/h2"
  css = ".view-content > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > div:nth-child(1) > div:nth-child(2) > a:nth-child(1) > h2:nth-child(1)"
  css = "a h2"
  what_is(page.find(:css, css))
  link = get_href(xpath)
  what_is(link)
  visit link
end

Given /^PENDING/ do
  pending
end

When("I do not see complaints about javascript") do
  expect(page).not_to have_css('div.antibot-no-js')
  expect(page).not_to have_content('Javascript')
  expect(page).not_to have_content('enable')
end

Given("I enter {string} for field {string}") do |string, string2|
  fill_in(string2, :with => string)
end

Given("I select {string} from popup {string}") do |string, string2|
  page.select string, from: string2
end

Given("I enter test email question into {string} with sequence {string} and tag {string}") do |string, string2, string3|
  fill_in("#{string}", :with => "This is a TEST EMAIL from a web form on www.library.cornell.edu. If you see this message, please forward the entire email to us at cul-web-test-confirm@cornell.edu so we'll know the web form email is working. After that, please delete it so no one else is bothered. Thanks. -JGReidy [webform-email-test;#{string2};#{string3}]")
end

Then("I hit Submit") do
  if ENV['SUBMIT'] == '1'
    # https://www.drupal.org/project/webform/issues/2906236
    # Honeypot complains if it took less than 5 sconds to fill out the form
    sleep_for(6)
    click_button("Submit")
  end
end

Then("I submit by hitting button {string}") do |string|
  # https://www.drupal.org/project/webform/issues/2906236
  # Honeypot complains if it took less than 5 sconds to fill out the form
  if ENV['SUBMIT'] == '1'
    sleep_for(6)
    click_button(string)
  end
end

Then ("I should not see a problem with submission message") do
  if ENV['SUBMIT'] == 1
    # Honeypot complaint
    wait_for(15) {
      expect(page).not_to have_content("problem with your form submission")
    }
  end
end

Then ("I should see a thank you message") do
  if ENV['SUBMIT'] == 1
    wait_for(15) {
      expect(page.find(:css, "div.alert-success")).to have_content("Thank you")
    }
  end
end

Then ("I should see a webform confirmation message") do
  if ENV['SUBMIT'] == 1
    wait_for(15) {
      expect(page.find(:css, "div.webform-confirmation")).to have_content("Thank you")
    }
  end
end

Then ("I use site {string} and stage {string}") do |string,string2|
  pending # can't figure out how to do this
  url = $anyini[":#{string}"][":#{string2}"]
  @url = {:domain => url}
  Capybara.app_host = @url[:domain]
end

Then("I log in with SAML") do
  wait_for(15) {
    target = "#{@url[:domain]}" + "/saml_login"
    visit target
    fill_in "netid", with: ENV["NETID"]
    fill_in "password", with: ENV["PASS"]
    click_button("Login")
    page.driver.within_frame('duo_iframe') do
      page.find(:css, "div.device-select-wrapper select").select("Android (xxx-xxx-8595)")
      click_button("Send Me a Push")
    end
  }
end

Then("user {string} is logged in") do |string|
  wait_for(15) {
    expect(page.find_by_id("toolbar-user")).to have_content(string)
  }
end

Then("I change the SMTP user") do
  page.find_by_id('search_box').send_keys "AKIAJD5ITLFLNISJE34Q"
end

Given("I show site, form, and recipient {string}") do |string|
  puts "Site: " + ENV['SITE'] + " Stage: " + ENV['STAGE']
  puts "Form: " + page.title
  puts "Recipient: " + string
end

Given("I enter periodic test text into {string} for user {string}") do |string, string2|
  text = Array.new
  text << "This is a TEST EMAIL from a web form on " + ENV['SITE']
  text << "See https://confluence.cornell.edu/x/e8AcFQ"
  text << "Form Name: " + page.title
  text << "Form URL: " + URI.parse(current_url).to_s
  text << "Recipient: " + string2
  text << "Test Campaign: " + "Periodic_submissions_for_email_gap_detection."
  text << "CUL-IT Tests: " + getTestMark()
  text << "Form: " + getTestMark(ENV['SITE'], page.title)
  text << "Run: " + getTestMark(ENV['SITE'], page.title, string2)
  wait_for(5) {
    fill_in("#{string}", :with => text.join("\n"))
  }
end

Then("show me id {string}") do |string|
  what_is(page.find_by_id(string, :visible => :all))
end

Then("show me xpath {string}") do |string|
  what_is(page.find(:xpath, "#{string}"))
end

Then("test hashing") do
  puts getTestMark
  puts getTestMark("apple")
  puts getTestMark("orange")
  puts getTestMark("1","1")
  puts getTestMark("1","2")
  puts getTestMark("1","1","1")
  puts getTestMark("1","1","2")
end

Given("I check off {string}") do |string|
  check(string)
end

Given("I uncheck {string}") do |string|
  uncheck(string)
end

Then /^I should see a Submit button labeled "(.*?)"$/ do |string|
  wait_for(5) {
    patiently do
      expect(page.find(:css, "button.webform-submit")).to have_content(string)
    end
  }
end

Then("I make jQuery load the page") do
  wait_for(200) {
    patiently do
      expect(page.find(:css, 'table#course-reserves-all-inline')).not_to be_empty
    end
  }
end

Then("there should not be a user logged in") do
  patiently do
    # this same css path shows user name if logged in
    expect(page.find(:css, 'div#maincontent.row.primary-wrapper h1')).to have_content("User account")
  end
end

Then("I should see the Staff login link") do
  expect(page.first(:xpath, "//a[text()='Staff login']"))
end

Then("I should be logged in to newcatalog") do
  expect(page.first(:css, "ul.blacklight-nav li a")).to have_content("Sign out")
end

Then("I log in with NETID and PASS") do
  fill_in "netid", with: ENV["NETID"]
  fill_in "password", with: ENV["PASS"]
  click_button("Login")
end

Then("I log in to the CUWebLogin page") do
  patiently do
    # remove any cookies
    expire_cookies

    # be sure we're at the CUWebAuth page
    find(:css, '.input-submit')
    expect(page.title).to eq('Cornell University Web Login')

    #login with the ENV vars
    fill_in "netid", with: ENV["NETID"]
    fill_in "password", with: ENV["PASS"]
    click_button("Login")

    # we should see the Two-Step login
    page.find(:css, 'form#duo_form')
    expect(page.find(:css, "#identity h1")).to have_content('Two-Step Login')

    # send a Push to the user's phone
    page.driver.within_frame('duo_iframe') do
      click_button("Send Me a Push")
      pause_for_user_input("Answer the phone for two-step verification")
      sleep_for(10)
    end
  end
end

Then("I send a Push to my phone") do
  patiently do
    page.driver.within_frame('duo_iframe') do
      click_button("Send Me a Push")
      pause_for_user_input("Answer the phone for two-step verification")
      sleep_for(10)
    end
  end
end

Then /^show me the cookies!$/ do
  show_me_the_cookies
end

Then /^show me the "([^"]*)" cookie$/ do |cookie_name|
  show_me_the_cookie(cookie_name)
end

Given /^I close my browser \(clearing the session\)$/ do
  expire_cookies
end


Then("I save the login") do
  $cookie_session = get_me_the_cookie('_session_id')
  $cookie_cuwltgttime = get_me_the_cookie('cuwltgttime')
  puts $cookie_cuwltgttime.to_yaml
end

Then("I restore saved login") do
  puts $cookie_cuwltgttime.to_yaml
  create_cookie('_session_id', $cookie_session)
  create_cookie('cuwltgttime', $cookie_cuwltgttime)
end


Then("I should see the Book Bag link") do
  patiently do
    expect(page.find(:css, "#bookmarks_nav")).to have_content("Book Bag")
  end
end

Then("I go to my Book Bag") do
  patiently do
    target = "#{@url[:domain]}" + "/book_bags/index"
    visit "#{target}"
  end
end

Then("I empty my Book Bag") do
  click_link('Clear all items')
end

Then("I have an empty Book Bag") do
  expect(page.first(:css, ".results-info p")).to have_content("You have no selected items.")
end

Then("I select the first {int} catalog results") do |int|
  patiently do
    page.assert_selector("input.toggle-bookmark", minimum: "#{int}")
    @all_checkboxes = page.all(:css, "input.toggle-bookmark")
  end
  i = 0
  while i < int
    page.find(:xpath, @all_checkboxes[i].path).set(true)
    i += 1
  end
end

Then("there should be {int} items seleted") do |int|
    expect(page.find(:xpath, '//span[@data-role="bookmark-counter"]').text).to match("#{int}")
end

Given("I view the catalog results") do
  page.find_by_id("search-btn").click
end

Then("I remove the first Book Bag item") do
  page.first("form.bookmark_toggle input.bookmark_remove").click
end