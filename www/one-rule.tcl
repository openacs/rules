ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Display of rules

} {
   rule_id:notnull
   qs:optional
   trigger:optional
}

set context [list "Rule Properties"]
set qs_id_2 0
if { ![exists_and_not_null qs]} {
    set qs ""
}
if { ![exists_and_not_null trigger]} {
    set trigger ""
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
        <a href=delete-trigger?rule_def_id=@rule_triggers.rule_def_id@&rule_id=$rule_id>Remove</a>
	}
    }
    qs_id {
	label "Question"
        display_template {
                   
                   <select name=edit_qs@rule_triggers.rule_def_id@  onChange=go@rule_triggers.rule_def_id@(@rule_triggers.rule_def_id@)>
                   <% set qs_id_2 @rule_triggers.qs_id@
	    db_multirow questions question {select question_id as qs_id, question_text as description
            from survey_questions where section_id = (select section_id from survey_sections where
            survey_id=(select asm_id from rules where rule_id=$rule_id)) 
} %>
                    <option value=@rule_triggers.qs_id@>@rule_triggers.description@
                     <multiple name="questions">
                    <option value=@questions.qs_id@>@questions.description@
                    </multiple>
                    </select>
               
	}
    }
    result_id {
	label "Result"
        display_template {


            <select name=edit_result@rule_triggers.rule_def_id@ onChange=result@rule_triggers.rule_def_id@(@rule_triggers.rule_def_id@)>
	    <% set q_id @rule_triggers.qs_id@
              db_multirow answers answers {select choice_id as result_id, label as value from survey_question_choices  where  question_id = :q_id} %>
                    <option value=@rule_triggers.result_id@>@rule_triggers.value@
	            <multiple name="answers">                    
                    <option value=@answers.result_id@>@answers.value@
                    </multiple>
                    </select>
                   
	}
    }
    active_p {
	label "Active"
	display_template {
	    <if @rule_triggers.active_p@ eq y>
	     Yes / <a href=change-active-trigger?rule_def_id=@rule_triggers.rule_def_id@&res=@rule_triggers.active_p@&rule_id=$rule_id>No</a>
	    </if>
	    <else >
            <a href=change-active-trigger?rule_def_id=@rule_triggers.rule_def_id@&res=@rule_triggers.active_p@&rule_id=$rule_id>Yes</a> / No
	    </else>
	}
    }
}
db_multirow rule_triggers get_triggers { *SQL* }




template::list::create -name actions\
-multirow rule_actions\
-key rule_action_id\
-no_data "There are no actions "\
-row_pretty_plural "actions"\
-elements {
    rule_action_id {
	display_template {
        <a href=delete-action?rule_action_id=@rule_actions.rule_action_id@&rule_id=$rule_id>Remove</a>
	}
    }

    action_type {
	label "Action"
	display_template {
	    <if @rule_actions.action_type@ eq "1">
	     Add user to
	    </if>
	    <if @rule_actions.action_type@ eq "2">
	     Add to list for
	    </if>
            <if @rule_actions.action_type@ eq "3">
              Add user to the System
            </if>
	}

	
    }
    group_id {
	label "Result"
	display_template {
            <select name=res@rule_actions.rule_action_id@ onChange=group@rule_actions.rule_action_id@()> 
            <%
	    db_multirow communities communities {select community_id,pretty_name from dotlrn_communities_all}
            %>     <if @rule_actions.group_id@ eq -1>
                   <option value=@rule_actions.group_id@>System
                   </if>
                   <else>
                   <option value=@rule_actions.group_id@>@rule_actions.name@
                   <multiple name="communities">
                   <option value=@communities.community_id@>@communities.pretty_name@
                   </multiple>
                   </select>
                   </else>
	}



    }
}
db_multirow rule_actions get_actions { *SQL* }

