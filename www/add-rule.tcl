ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Add new rule related to an Assessment
} {
   rule_id:optional
   return_url:optional
} -properties {
  context
}

# Just while I get the assessment package ready
auth::require_login
set package_id [ad_conn package_id]
set context [list "Add rule"]


set assessments [rules::rule::get_assessments]
ad_form -name  add_rule  -export { return_url } -form {
     rule_id:key     
    { rule_name:text(text) 
	{label "Rule Name"}
    }
    {asm_id:text(select)
	{label "Assessment Related"}
        {options $assessments}
    }
    {active_p:text(select)
	{label "Active"}
	{options {{Yes y} { No n}}}
    }
} -new_data  {
    set user_id [ad_conn user_id]   
    set rule_id [rules::rule::new_rule -rule_id $rule_id -rule_name $rule_name -asm_id $asm_id -active_p $active_p]
    permission::grant -object_id $rule_id -privilege "admin" -party_id $user_id
    
 } -edit_request {
     db_1row get_rule_properties {select * from rules where rule_id=:rule_id} 
 } -edit_data {

     db_dml update_rule { update rules set rule_name=:rule_name, active_p=:active_p, asm_id=:asm_id where rule_id=:rule_id }
 } -after_submit {
     
  ad_returnredirect $return_url
}
