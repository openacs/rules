ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Display of rules

} {
   rule_id:notnull
   qs:optional
   trigger:optional
}
permission::require_permission -object_id $rule_id -privilege "admin"
set counter [db_string question { select count(rule_def_id) from rules_triggers where rule_id=:rule_id}]


if { $counter == 0 } {
    ad_returnredirect "single-rule-add?rule_id=$rule_id"
}

set context [list "Rule Properties"]
set qs_id_2 0
if { ![exists_and_not_null qs]} {
    set qs ""
}
if { ![exists_and_not_null trigger]} {
    set trigger ""
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
template::list::create -name triggers\
-multirow rule_triggers\
-key rule_def_id\
-no_data "There are no triggers "\
-row_pretty_plural "triggers"\
-elements {
    rule_def_id {
	display_template {
<a href=single-rule-add?rule_def_id=@rule_triggers.rule_def_id@&rule_id=$rule_id&s_qs=@rule_triggers.qs_id@&s_answer=@rule_triggers.result_id@&s_action=@rule_triggers.action_type@&s_group=@rule_triggers.group_id@><img border=0 src=images/Edit16.gif></a>
        <a href=delete-single-rule?return_url=single-rule&rule_def_id=@rule_triggers.rule_def_id@&rule_id=$rule_id><img border=0 src=images/Delete16.gif></a>         
	}
    }
    qs_id {
	label "Question"
        display_col  description        
	
    }
    result_id {
	label "Answer"
        display_col value
                  
    }
    active_p {
	label "Active"
	display_template {
	    <if @rule_triggers.active_p@ eq y>
	     Yes 
	    </if>
	    <else >
              No
	    </else>
	}
    }
    action_type {
	label "Action"
	display_template {
	    <if @rule_triggers.action_type@ eq "1">
	     Add Automatically
	    </if>
	    <if @rule_triggers.action_type@ eq "2">
	     Add to waiting list
	    </if>
	}

	
    }
    group_id {
	label "Result"
	display_template  {
                  <if @rule_triggers.group_id@ eq -1>
                   to website
                  </if>
                   <else>
                   @rule_triggers.name@
                   </else>
	}

    }

}
db_multirow rule_triggers get_triggers { *SQL* }



