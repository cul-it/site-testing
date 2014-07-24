How to generate test cases:

export a path/title for each film with this:

http://kluge.test1.library.cornell.edu/admin/structure/views/view/path_list/edit/views_data_export_1

export a path & title for each segment with this:

http://kluge.test1.library.cornell.edu/admin/structure/views/view/path_list/edit/views_data_export_2

import both exported files into the database at
kluge-test-formatter.fmp12

export the 'Test' field from Filemaker into
kluge-video-segment-test-table-rows.tab

embed that output in the <table>...</table> in
test-videos-segments

Then load test-videos-segments into Seleniup, point it at
http://kluge.test1.library.cornell.edu
and run all the tests
