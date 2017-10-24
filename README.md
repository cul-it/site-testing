## site-testing

cucumber tests for web sites

```
bundle exec cucumber SITE=www.library.cornell.edu STAGE=prod
bundle exec cucumber SITE=www.library.cornell.edu STAGE=prod HEADLESS=1  HEADLESS_BROWSER=poltergeist POLTERGEIST_DEBUG=1
```
### Stages

* `dev`
* `test`
* `live` - (live-xyzcornelledu.panthion.io)
* `prod` - (actual domain name)

These are set up in site-testing.ini

### Headless Browsers

* `poltergeist` (default)
* `selenium_chrome_headless`
* `headless_chrome`

### Piwik problem

You may see a failed test like this:

```
Given I go to the home page               # features/step_definitions/custom_steps.rb:66
      Request to 'https://wwwtest.library.cornell.edu' failed to reach server, check DNS
      and/or server status - Timed out with the following resources still waiting
      https://webstats.library.cornell.edu/piwik.js (Capybara::Poltergeist::StatusFailError)
```

Sites using the piwik module will not be able to be loaded by these tests,
*unless*
you go to

```
/admin/config/system/piwik
```

under Advanced Settings and check off

```
☑︎ Locally cache tracking code file
```
