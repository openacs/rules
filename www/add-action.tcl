ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Add new rule related to an Assessment
} {
    rule_id:notnull
    selected_a:optional
}

set default_action 1

# Just while I get the assessment package ready
set context [list [list "one-rule?rule_id=$rule_id" "Rule Properties"] "Add Action"]
if { [exists_and_not_null selected_a]} {
      set default_action $selected_a
}

set actions { {"add user to" 1} {"add to list of" 2} {"add user to the system" 3}}
set results [list]
if { $default_action != 3 } {
db_foreach communities { *SQL* } {
    lappend results [list $pretty_name $community_id]
} 
} else {
    lappend  results [list "System" -1]
}


form create add_action

element create add_action rule_id\
     -datatype text\
     -widget hidden \
     -value $rule_id
 
element create add_action action_type\
     -datatype text\
     -widget select\
     -label "Action"\
     -options $actions\
     -html { onChange getAction()}\
     -value $default_action
    
element create add_action group_id\
      -datatype text\
      -widget select\
      -label "Community"\
      -options $results

element create add_action active_p\
      -datatype text\
      -widget select\
      -label "Active"\
      -options {{Yes y} { No n}}

   if {[template::form is_valid add_action]} {
    template::form get_values add_action action_type  group_id  active_p
    rules::rule::add_action -action_type  $action_type  -group_id  $group_id -rule_id $rule_id -active_p $active_p
    ad_returnredirect "one-rule?rule_id=$rule_id"
}
