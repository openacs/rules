ad_page_contract {
    Display of rules
    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {

}


template::list::create -name rules\
-multirow all_rules\
-key rule_id\
-bulk_actions {
    "Delete" "delete-rule" "Delete checked rules"
    "Edit" "add-rule" "Edit checked rules"
}\
-bulk_action_method post -bulk_action_export_vars {
    rule_id
}\
-no_data "There are no rules"\
-row_pretty_plural "all rules"\
-elements {
    rule_name {
	label "Rule Name"
        link_url_eval {[export_vars -base one-rule { rule_id}]}
	
    }
    asm_name {
	label "Related Questionnarie"
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
	    <a href=request-notification?object_id=@all_rules.rule_id@&type_id=[notification::type::get_type_id -short_name rule_notif]&return_url=index>Notify user</a>
	  
	}
    }
}
db_multirow all_rules all_rules { *SQL* }

