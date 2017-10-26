#!/bin/bash
set -e
PATH=$PWD/bin:$PATH
GEM_HOME=/usr/local/rvm/gems/ruby-2.2.5
PATH=/usr/local/rvm/gems/ruby-2.2.5/bin:$PATH
source /etc/profile.d/rvm.sh
rvm use ruby-2.2.5
which bundle
bundle install
SITES=( ac.library.cornell.edu africana.library.cornell.edu alumni.library.cornell.edu annex.library.cornell.edu anthrocollections.library.cornell.edu antiquities.library.cornell.edu artifactsandart.library.cornell.edu asia.library.cornell.edu catherwood.library.cornell.edu chinapreservationtutorial.library.cornell.edu copyright.cornell.edu corpusjuris.cornell.edu costume.library.cornell.edu cull-users.library.cornell.edu cuneiform.library.cornell.edu dataresearch.cornell.edu dcaps.library.cornell.edu digitalhumanities.library.cornell.edu dynkincollection.library.cornell.edu efraimracker.library.cornell.edu engineering.library.cornell.edu finearts.library.cornell.edu ghali.library.cornell.edu hlm.library.cornell.edu iiiftest.library.cornell.edu johnclairmiller.library.cornell.edu johnreps.library.cornell.edu johnson.library.cornell.edu kluge.library.cornell.edu latamjournals.library.cornell.edu law.library.cornell.edu lts.library.cornell.edu mathematics.library.cornell.edu middleeast.library.cornell.edu music.library.cornell.edu olinuris.library.cornell.edu persuasivemaps.library.cornell.edu physicalsciences.library.cornell.edu physicalsciences8.library.cornell.edu plates.library.cornell.edu rare.library.cornell.edu seapapers.library.cornell.edu signale.cornell.edu storage.library.cornell.edu vet.library.cornell.edu warburg.library.cornell.edu wordsworth.library.cornell.edu www.ld4l.org www.library.cornell.edu )
for SITE in "${SITES[@]}"
do
  bundle exec cucumber SITE=www.library.cornell.edu STAGE=prod HEADLESS=1 --tags @site_up
done
