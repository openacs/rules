ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Display of rules

} {
   rule_def_id:optional
   rule_id:notnull
   s_qs:optional
   s_answer:optional
   s_active:optional
   s_group:optional
   s_action:optional
}

set default_action 1
set default_active "y"
set default_group "-1"
set default_answer 0
set exp_trigger ""
set context [list "Single Rule Properties"]
set questions [list]
set results [list]
set communities [list]
set count 0
set id ""
set mode ""
permission::require_permission -object_id $rule_id -privilege "admin"
if { [exists_and_not_null rule_def_id] } {
   set exp_trigger "&rule_def_id=$rule_def_id"
   set mode "edit"
   set id $rule_def_id
} else {
   set mode "new"
}

db_foreach communities { *SQL* } {
    lappend communities [list $pretty_name $community_id]
}
    lappend  communities [list "to website" -1]


set actions { {"Add Automatically" 1} {"Add to waiting list " 2}}

db_foreach questions { *SQL* } {
    incr count
    if  { $count == 1 && ![exists_and_not_null s_qs]} { 
          set s_qs  $qs_id
      } 
     set question [list $description $qs_id]
     lappend questions $question
}
if { $count == 0 } {
 set s_qs 0
}

db_foreach results { *SQL* } {
    lappend results [list $value $result_id]
}
if { [exists_and_not_null s_action]} {
  set default_answer $s_action
}


if { [exists_and_not_null s_answer]} {
  set default_answer $s_answer
}
if { [exists_and_not_null s_active]} {
  set default_active $s_active
}
if { [exists_and_not_null s_action]} {
      set default_action $s_action
}
if { [exists_and_not_null s_group]} {
  set default_group $s_group
}
set rule_name [db_string rule_name {select rule_name from rules where rule_id=:rule_id}]
set assessment_related [db_string asm { select name from surveys where survey_id = (select asm_id from rules where rule_id=:rule_id)}]
set state [db_string active_p {select active_p from rules where rule_id=:rule_id}]

if { $state == "y"} {
   set state "Active"
} else {
  set state "Not Active"
}

set type_id [notification::type::get_type_id -short_name rule_notif]


ad_form -name add_trigger  -export { id mode } -form {
    { rule_id:text(hidden)
	{value $rule_id}
    }

    { qs_id:text(select)
	{label ""}
	{options $questions}
	{value $s_qs}
	{html  { onChange go()}}
    }
    {result_id:text(select)
	{label ""}
	{options $results}
	{value $default_answer}
    }
    {active_p:text(select)
	{label ""}
	{options {{Yes y} { No n}}}
	{value $default_active}
    }
    {action_type:text(select)
	{label ""}
	{options $actions}
	{value $default_action}
    }
    {group_id:text(select)
	{label ""}
	{options $communities}
	{value $default_group}
    }
    {submit:text(submit)
	{label " Submit "}
    }
} -on_submit {
if { $mode == "new"} { 
    set rule_action_id [db_string next_action { *SQL* }]
    set rule_def_id [db_string next_trigger { *SQL* }]
    set id $rule_def_id

    db_dml insert_action { *SQL* }
    db_dml insert_trigger { *SQL* }
} else {
    db_dml update_action { *SQL* }
    db_dml update_trigger { *SQL* }
}
} -after_submit {
      ad_returnredirect "single-rule?rule_id=$rule_id"
}



    
    
