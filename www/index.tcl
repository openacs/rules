ad_page_contract {
    Display of rules
    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {

}


set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set context [list "Add rule"]
set rule_admin ""
set admin [permission::permission_p -object_id $package_id -party_id $user_id -privilege "admin"]

template::list::create -name rules\
-multirow all_rules\
-key rule_id\
-bulk_actions {
    "Delete" "delete-rule" "Delete checked rules"
}\
-bulk_action_method post -bulk_action_export_vars {
    rule_id
}\
-no_data "There are no rules"\
-row_pretty_plural "all rules"\
-elements {
    rule_name {
	label "Rule Name"
        display_template
        {
         <a href=add-rule?rule_id=@all_rules.rule_id@&return_url=index><img border=0 src=images/Edit16.gif></a> <a href=one-rule?rule_id=@all_rules.rule_id@>@all_rules.rule_name@</a>
	}

	
    }
    asm_name {
	label "Related Questionnaire"
	link_url_eval {../survey/admin/one?survey_id=$asm_id}
    }
    active_p {
	label "Active"
	display_template {
	    <if @all_rules.active_p@ eq y>

	     Yes / <a href=change-active?rule_id=@all_rules.rule_id@&res=@all_rules.active_p@>No</a>
	    </if>
	    <else >
            <a href=change-active?rule_id=@all_rules.rule_id@&res=@all_rules.active_p@>Yes</a> / No
	    </else>
	}
    }
        rule_id {
	label "Notifications"
	display_template {
	    <a href=request-notification?object_id=@all_rules.rule_id@&type_id=[notification::type::get_type_id -short_name rule_notif]>Notify user</a>
	  
	}
    }
}
db_multirow all_rules all_rules { *SQL* }

