ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {
    interval:optional
    specific_date:optional
    state:optional
    community:optional
    rule:optional
}

set communities_list [list]
set rules_list [list]
lappend communities_list [list "All" "all"]
lappend communities_list [list "System" "-1"]
lappend rules_list [list "All" "all"]

db_foreach  community {select community_id,pretty_name from dotlrn_communities_all} {
    lappend communities_list [list $pretty_name $community_id]
}
db_foreach rules { select * from rules } {
    lappend rules_list [list $rule_name $rule_id]
}

set approved_options [list [list "Not Approved" n] [list "Approved" y]]

set today [db_string today {select to_date(sysdate,'YYYY-MM-DD') from dual}]
set yesterday [db_string yesterday {select to_date(sysdate-1,'YYYY-MM-DD') from dual}]
set last_week  [db_string last_week  {select to_date(sysdate-7,'YYYY-MM-DD') from dual}]
set two_days  [db_string two_weeks {select to_date(sysdate-2,'YYYY-MM-DD') from dual}]
set last_month [db_string last_month {select to_date(sysdate-30,'YYYY-MM-DD') from dual}]

set default_interval "all"
set default_specific_date  ""
set default_community "all"
set default_state "n"
set default_rule "all"

set date_options [list [list "All" "all"] [list "Today" $today] [list "Yesterday" $yesterday] [list "Two days ago" $two_days] [list "Last Week" $last_week] [list "Last Month" $last_month]]
  
set community_query ""
set rule_query ""

if {[exists_and_not_null community] && $community != "all" } {
   set default_community $community
   set community_query " and r.group_id= $default_community"

}
if {[exists_and_not_null rule] && $rule != "all" } {

   set default_rule $rule
   set rule_query " and r.rule_action_id in (select rule_action_id from rules_actions where rule_id = $default_rule)"

}

if {[exists_and_not_null state]} {
    set default_state $state;
} 
set interval_query ""
set specific_date_query ""

if {[exists_and_not_null interval] && $interval != "all" } {
    set default_interval $interval
    if { $interval == $today  ||  $interval == $yesterday || $interval== $two_days} {
        set interval_query " and to_char(request_date,'YYYY-MM-DD') = '$interval'"
    } else {
        set interval_query " and to_char(request_date,'YYYY-MM-DD') > '$interval' and to_char(request_date,'YYYY-MM-DD') <= '$today'"
    } 
} 
if {[exists_and_not_null specific_date]} {
   set default_specific_date $specific_date
   set specific_date_query "and to_char(request_date,'YYYY-MM-DD') = '$default_specific_date'"
} 

 set query "select r.rha_id,r.user_id,(select p.first_names || ' ' || p.last_name as name from persons p where p.person_id = r.user_id) as user_name, (select pretty_name from dotlrn_communities_all where community_id=r.group_id) as group_name, r.group_id,r.rule_action_id,to_date(r.request_date,'YYYY-MM-DD') as request_date ,r.approved_p from rule_history_actions r where approved_p='$default_state' $community_query $interval_query $specific_date_query $rule_query"



form create communities -has_submit
element create communities community_id\
      -datatype text\
      -widget select\
      -label "Group Name"\
      -options $communities_list\
      -html { onChange "get_community()"}\
      -value $default_community

element create communities approved_p\
      -datatype text\
      -widget select\
      -label ""\
      -options $approved_options\
      -html { onChange "get_state()"}\
      -value $default_state

form create interval -has_submit 1
element create interval date\
      -datatype text\
      -widget select\
      -label "Date of Request"\
      -options $date_options\
      -html { onChange "get_interval()"}\
      -value $default_interval

form create specific_date -has_submit 1
element create specific_date community \
    -datatype text\
    -widget hidden\
    -value $default_community
element create specific_date state \
    -datatype text\
    -widget hidden\
    -value $default_state
element create specific_date rule \
    -datatype text\
    -widget hidden\
    -value $default_rule

element create specific_date specific_date \
    -label "" \
    -datatype text\
    -widget text \
    -optional\
    -value $default_specific_date\
    -html {id sel2}\
    -after_html {<input type='reset' value=' ... ' onclick="return showCalendar('sel2', 'y-m-d');">[<b>YYYY-MM-DD</b>]}

element create specific_date date submit\
      -widget submit\
      -label "Specific Date"\
      -html { onClick "get_specific_date()"}

form create rules -has_submit
element create rules rule_id\
      -datatype text\
      -widget select\
      -label "Rule Name"\
      -options $rules_list\
      -html { onChange "get_rule()"}\
      -value $default_rule

template::list::create -name requests\
-multirow requests\
-key rha_id\
-bulk_actions {
  "Bulk Mail" "bulk-mail" "Send mail to all users"
  "Approve" "approve-users" "Approve users requests"
}\
-bulk_action_method post -bulk_action_export_vars {
    {interval $default_interval}
    {rule $default_rule}
    {community $default_community}
    {specific_date $default_specific_date}
    {state $default_state}
}\
-no_data "There are no requests"\
-row_pretty_plural "requests"\
-elements {
    user_id {
	label "User"
        display_col user_name
    }
    group_id {
         label "Group Name"
	display_template {
             < if @requests.group_id@ eq -1>
               System
             </if> <else> 
               @requests.group_name@
             </else>
	}
    }
    request_date {
         label "Request Date"
        
    }
    approved_p {
         label "Approved"
	display_template {
         <if @requests.approved_p@ eq y>
                  Yes
         </if> 
         <else>
                No
         </else>
	} 
    }
}

db_multirow requests requests $query
