ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Add new rule related to an Assessment
} {
    rule_id:notnull
    selected_qs:optional
}
ad_maybe_redirect_for_registration
set qs_sel 0
set context [list [list "one-rule?rule_id=$rule_id" "Rule Properties"] "Add Trigger"]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set context [list "Add rule"]
set rule_admin ""
set admin [permission::permission_p -object_id $package_id -party_id $user_id -privilege "admin"]
if { [exists_and_not_null rule_id] } {
set rule_admin [permission::permission_p -object_id $rule_id -party_id $user_id -privilege "admin"]
}


# Just while  get the assessment package ready

set questions [list]
set results [list]
set count 0
set first_qs 0

db_foreach questions { *SQL* } {
    incr count
    if  { $count == 1 && ![exists_and_not_null selected_qs]} { 
          set selected_qs  $qs_id
      } 
     set question [list $description $qs_id]
     lappend questions $question
}
if { $count == 0 } {
 set selected_qs 0
}
if { ![exists_and_not_null selected_qs]} {
       set qs_sel $selected_qs
} else {
       set qs_sel $selected_qs
}


db_foreach results { *SQL* } {
     set result  [list $value $result_id]
     lappend results $result

}


form create add_trigger

element create add_trigger rule_id\
     -datatype text\
     -widget hidden \
     -value $rule_id
 
element create add_trigger qs_id\
     -datatype text\
     -widget select\
     -label "Question"\
     -options $questions\
     -value $selected_qs\
     -html { onChange go()}
    
element create add_trigger result_id\
      -datatype text\
      -widget select\
      -label "Result"\
      -options $results


element create add_trigger active_p\
      -datatype text\
      -widget select\
      -label "Active"\
      -options {{Yes y} { No n}}
    
if {[template::form is_valid add_trigger]} {
    template::form get_values add_trigger qs_id  result_id active_p
    rules::rule::add_trigger -qs_id $qs_id -result_id $result_id -rule_id $rule_id -active_p $active_p
    ad_returnredirect "one-rule?rule_id=$rule_id"
}
