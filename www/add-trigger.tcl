ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Add new rule related to an Assessment
} {
    rule_id:notnull
    selected_qs:optional
}

set qs_sel 0
set context [list [list "one-rule?rule_id=$rule_id" "Rule Properties"] "Add Trigger"]
# Just while  get the assessment package ready
if { ![exists_and_not_null selected_qs]} {
       set selected_qs 01
       set qs_sel $selected_qs
} else {
       set qs_sel $selected_qs
}

set questions [list]
set results [list]

db_foreach questions { *SQL* } {
    set question [list $description $qs_id]
    lappend questions $question
}
db_foreach results { *SQL* } {
    set result [list $value $result_id]
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
