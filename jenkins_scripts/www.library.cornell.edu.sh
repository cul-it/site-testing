#!/bin/bash
set -e
PATH=$PWD/bin:$PATH
GEM_HOME=/usr/local/rvm/gems/ruby-2.2.5
PATH=/usr/local/rvm/gems/ruby-2.2.5/bin:$PATH
source /etc/profile.d/rvm.sh
rvm use ruby-2.2.5
which bundle
bundle install
SITE=www.library.cornell.edu
bundle exec cucumber SITE="$SITE" STAGE=prod HEADLESS=1 --tags @www_site_up @www_ares
@www_login_required @www_hours @www_search
