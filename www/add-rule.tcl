ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Add new rule related to an Assessment
} {
   rule_id:optional
} -properties {
  context
}

# Just while I get the assessment package ready

set context [list "Add rule"]

set assessments [rules::rule::get_assessments]
ad_form -name  add_rule  -form {
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
   
     rules::rule::new_rule -rule_id $rule_id -rule_name $rule_name -asm_id $asm_id -active_p $active_p
    
 } -edit_request {
     db_1row get_rule_properties {select * from rules where rule_id=:rule_id} 
 } -edit_data {
     db_dml update_rule { update rules set rule_name=:rule_name, active_p=:active_p, asm_id=:asm_id where rule_id=:rule_id }
 } -after_submit {
  ad_returnredirect "index"
}
