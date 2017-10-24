## site-testing

cucumber tests for web sites

```
bundle exec cucumber SITE=www.library.cornell.edu STAGE=prod
bundle exec cucumber SITE=www.library.cornell.edu STAGE=prod HEADLESS=1  HEADLESS_BROWSER=poltergeist POLTERGEIST_DEBUG=1
```
## Stages

* dev
* test
* live - (live-xyzcornelledu.panthion.io)
* prod - (actual domain name)

These are set up in site-testing.ini

## Headless Browsers

* poltergeist
* selenium_chrome_headless
* headless_chrome (default)
