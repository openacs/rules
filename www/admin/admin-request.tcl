ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {
}

set communities_list [list]

lappend communities_list [list "All" ""]

db_foreach  community {select community_id,pretty_name from dotlrn_communities_all} {
    lappend communities_list [list $pretty_name $community_id]
}

set approved_options [list [list "Not Approved" n] [list "Approved" y]]

set today [db_string today {select sysdate from dual}]
set yesterday [db_string yesterday {select (sysdate-1) from dual}]
set last_week  [db_string last_week  {select (sysdate-7) from dual}]
set two_days  [db_string two_weeks {select (sysdate-2) from dual}]
set last_month [db_string last_month {select (sysdate-30) from dual}]

set date_options [list [list "All" ""] [list "Today" $today] [list "Yesterday" $yesterday] [list "Two days ago" $two_days] [list "Last Week" $last_week] [list "Last Month" $last_month]]
form create communities -has_submit
element create communities community_id\
      -datatype text\
      -widget select\
      -label "Group Name"\
      -options $communities_list
element create communities approved_p\
      -datatype text\
      -widget select\
      -label ""\
      -options $approved_options

form create date -has_submit 1
element create date date\
      -datatype text\
      -widget select\
      -label "Date of Request"\
      -options $date_options

element create date submit\
      -widget submit\
      -label "Specific Date"



